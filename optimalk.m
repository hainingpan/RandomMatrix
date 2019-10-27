function k=optimalk(t,L)
switch L
    
    case 2
        switch t
            case 0.5
                k=3;
            case 1
                k=4;
            otherwise
                k=4;
        end
        
    case 3
        switch t
            case 0.5
                k=5;
            case 1
                k=3;
            otherwise
                k=4;
        end
    
    case 4
        switch t
            case 0.5
                k=5;
            case 1
                k=6;
            otherwise
                k=6;
        end
        
    case 5
        switch t
            case 0.5
                k=5;
            case 1
                k=5;
            otherwise
                k=5;
        end   
        
    case 6
        switch t
            otherwise
                k=7;
        end
        
    case 7
        switch t
            otherwise
                k=8;
        end
        
    case 8
        switch t
            case 0.5
                k=8;
            case 1
                k=10;
            otherwise
                k=9;
        end      
        
    case 9
        switch t
            otherwise
                k=12;
        end  
    
    case 10
        switch t
            otherwise
                k=14;
        end  
   
        
    case 15
    switch t
        case 0.5
            k=25;
        case 1
            k=20;
        otherwise
            k=20;
    end  
    
    case 20
        switch t
            case 0.5
                k=25;
            case 1
                k=26;
            otherwise
                k=26;
        end  
        
        
    otherwise
        k=10;
end
