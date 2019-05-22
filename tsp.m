load('M80/N4/Gn0.1/enmap0.mat')
alpha1list=0:0.005:1;
alpha2list=0:0.005:1;
figure;
[matcont,valcont]=contour(alpha1list,alpha2list,enmap0',[2,6],'k');
xlabel('\alpha_1');
ylabel('\alpha_2');
matcontx=matcont(1,:);
matconty=matcont(2,:);
stopx=matcontx(0<=matcontx&matcontx<=1);
stopy=matconty(0<=matcontx&matcontx<=1);
% 
% stopx=stopx(1:800);
% stopy=stopy(1:800);

nstop=length(stopx);
figure;scatter(stopx,stopy,'.');

idxs = nchoosek(1:nstop,2);
dist = hypot(stopx(idxs(:,1)) - stopx(idxs(:,2)), stopy(idxs(:,1)) - stopy(idxs(:,2)));
lendist = length(dist);
Aeq = spones(1:length(idxs)); % Adds up the number of trips
beq = nstop;

Aeq = [Aeq;spalloc(nstop,length(idxs),nstop*(nstop-1))]; % allocate a sparse matrix
for ii = 1:nstop
    whichIdxs = (idxs == ii); % find the trips that include stop ii
    whichIdxs = sparse(sum(whichIdxs,2)); % include trips where ii is at either end
    Aeq(ii+1,:) = whichIdxs'; % include in the constraint matrix
end
beq = [beq; 2*ones(nstop,1)];

intcon = 1:lendist;
lb = zeros(lendist,1);
ub = ones(lendist,1);
opts = optimoptions('intlinprog','Display','iter','HeuristicsMaxNodes',100,'ObjectiveImprovementThreshold',0.1,...
    'CutMaxIterations',25,'CutGeneration','advanced','BranchRule','strongpscost','RelativeGapTolerance',0.1);
tic;
[x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);
toc;

segments = find(x_tsp);
idxs1=idxs(:,1);
idxs2=idxs(:,2);
idxs1=idxs1(logical(x_tsp));
idxs2=idxs2(logical(x_tsp));
grph=graph(idxs1,idxs2);
adj=adjacency(grph);


pinx=0.3;
piny=0.4;
idx=knnsearch([stopx;stopy]',[pinx,piny]);

starti=idx;
startj=1;
traj=[starti];
curi=starti;
curj=startj;
nextj=find(adj(curi,1:curj-1));
if isempty(nextj)
    nextj=find(adj(curi,curj+1:end),1)+curj;
end
curj=curi;
curi=nextj;
traj=[traj,curi];
while curi~=starti   
    nextj=find(adj(curi,1:curj-1));
    if isempty(nextj)
        nextj=find(adj(curi,curj+1:end))+curj;
    end
    curj=curi;
    curi=nextj;
    traj=[traj,curi];
end

