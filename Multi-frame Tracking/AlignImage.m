function [A_refined] = AlignImage(template, target, A)

[Ix,Iy] = imgradientxy(template);
Hessian = zeros(6,6);

for i = 1:size(template,1)
    for j = 1:size(template,2)
       Jacobian = [j,i,1,0,0,0; 0,0,0,j,i,1];
       Hessian = Hessian + ([Ix(i,j),Iy(i,j)]*Jacobian)'*([Ix(i,j),Iy(i,j)]*Jacobian);
    end
end

error = [];
for k = 1:250
    I_warped = zeros(size(template),class(template));
    F = zeros(6,1);
    for i = 1:size(template,1)
        for j = 1:size(template,2)
            point = A*[j,i,1]';
            if (i<1 || i> size(template,1) || j<1 || j> size(template,2))
                continue;
            end
            Jacobian = [j,i,1,0,0,0; 0,0,0,j,i,1];
            I_warped(i,j) = target(floor(point(2)),floor(point(1)));
            I_errorimage = I_warped(i,j) - template(i,j);
            F = F + ( ([Ix(i,j),Iy(i,j)]*Jacobian)' * double(I_errorimage) );
        end
    end
    
    p = Hessian\F;
    A_p = [p(1)+1,p(2),p(3); p(4),p(5)+1,p(6); 0,0,1];
    A = A/A_p;
    err = norm(double((I_warped-template)), 'fro');
    error = [error; abs(err)];
  
    if (norm(p,'fro') < 0.01)
        break;
    end

end

A_refined=A;

end