function [ A ] = chebbcmatrix( nbc,trange )
%CHEBBCMATRIX  chebychev (First kind) polynomial  matrix to ecvaluate
%                boundary conditions
%                i.e Tn(x)   and the n derivatives at x=[-1,1] mapped to
%                [to,tf]
%  nbc - number of boundary conditions (even number) 
%  trange - time range [t0,tf]
%  A - matrix
% 
% derivative recursion formula (Wikipedia)
% \frac{d^p T_n}{d x^p} \Bigg|_{x = \pm 1}   = (\pm 1)^{n+p}\prod_{k=0}^{p-1}\frac{n^2-k^2}{2k+1}
%
% jfw 6/7/12


nT=nbc-1; % Chebychev order
np=nbc/2-1; % max derivative number

% calculate T_n at [-1,1] for n=0:nbc-1 (in columns) and derivatives (in the rows)

% first calculate T_n matrix at x=+1
Tn1=zeros(nbc/2,nbc);
Tn1(1,1:nbc)=1; % zeroth derivative

% calculate d^p T_n/dx^n
for n=1:nT  %   T_n
    for p=1:np % p is derivative number
        if(n>=p) % if derivative exists
            P=1;
            for k=0:p-1
                if n>=k% now do recursion
                    P=(n^2-k^2)/(2*k+1)*P;
                end
            end 
            Tn1(p+1,n+1)=P;
        end
    end
end

%  T_n matrix at x=-1
nn=[0:nbc-1];
signcol=diag((-1).^nn);% 
signrow=diag((-1).^nn(1:nbc/2));
Tn2=signrow*Tn1*signcol;

% now map Tn matrices from [-1,1] range to [t0,tf] range to get A
st=2/(trange(2)-trange(1)); % time mapping
A = [diag(st.^nn(1:nbc/2))*Tn2; 
     diag(st.^nn(1:nbc/2))*Tn1]; 
 mon=1;

return
