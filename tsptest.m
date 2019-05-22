figure;

load('usborder.mat','x','y','xx','yy');
rng(2,'twister') % makes a plot with stops in Maine & Florida, and is reproducible
nStops = 30; % you can use any number, but the problem size scales as N^2
stopsLon = zeros(nStops,1); % allocate x-coordinates of nStops
stopsLat = stopsLon; % allocate y-coordinates
n = 1;
while (n <= nStops)
    xp = rand*1.5;
    yp = rand;
    if inpolygon(xp,yp,x,y) % test if inside the border
        stopsLon(n) = xp;
        stopsLat(n) = yp;
        n = n+1;
    end
end
plot(x,y,'Color','red'); % draw the outside border
hold on
% Add the stops to the map
plot(stopsLon,stopsLat,'*b')

for ii=1:nStops
    lbl{ii}=num2str(ii);
end
text(stopsLon+0.02,stopsLat+0.02,lbl);

idxs = nchoosek(1:nStops,2);

dist = hypot(stopsLat(idxs(:,1)) - stopsLat(idxs(:,2)), stopsLon(idxs(:,1)) - stopsLon(idxs(:,2)));
lendist = length(dist);
Aeq = spones(1:length(idxs)); % Adds up the number of trips
beq = nStops;

Aeq = [Aeq;spalloc(nStops,length(idxs),nStops*(nStops-1))]; % allocate a sparse matrix
for ii = 1:nStops
    whichIdxs = (idxs == ii); % find the trips that include stop ii
    whichIdxs = sparse(sum(whichIdxs,2)); % include trips where ii is at either end
    Aeq(ii+1,:) = whichIdxs'; % include in the constraint matrix
end
beq = [beq; 2*ones(nStops,1)];

intcon = 1:lendist;
lb = zeros(lendist,1);
ub = ones(lendist,1);

opts = optimoptions('intlinprog','Display','off');
[x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);



segments = find(x_tsp); % Get indices of lines on optimal path

for i=1:length(segments)
    fprintf("%d->%d\n",idxs(segments(i),:));
end

idxs1=idxs(:,1);
idxs2=idxs(:,2);
idxs1=idxs1(logical(x_tsp));
idxs2=idxs2(logical(x_tsp));
grph=graph(idxs1,idxs2);
adj=adjacency(grph);

starti=1;
startj=1;
path=[starti];
curi=starti;
curj=startj;
nextj=find(adj(curi,1:curj-1));
if isempty(nextj)
    nextj=find(adj(curi,curj+1:end),1)+curj;
end
curj=curi;
curi=nextj;
path=[path,curi];
while curi~=starti   
    nextj=find(adj(curi,1:curj-1));
    if isempty(nextj)
        nextj=find(adj(curi,curj+1:end))+curj;
    end
    curj=curi;
    curi=nextj;
    path=[path,curi];
end

lh = zeros(nStops,1); % Use to store handles to lines on plot
lh = updateSalesmanPlot(lh,x_tsp,idxs,stopsLon,stopsLat);
title('Solution with Subtours');
