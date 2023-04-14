function elasti = elasti_cal(te)
    if length(te) < 2
        error('elasti_cal: need at least x, y as inputs');
    end

    if length(te) == 2
        xs = te{1}; ys = te{2};
        xs = reshape(xs,length(xs),1);
        ys = reshape(ys,length(ys),1);
        iuse =(isnan(xs)~=1) & (isnan(ys)~=1);
        x = xs(iuse); y = ys(iuse);
        w=0*x +1;
    else
        xs = te{1}; ys = te{2}; ws = te{3};
        xs = reshape(xs,length(xs),1);
        ys = reshape(ys,length(ys),1);
        ws = reshape(ws,length(ws),1);
        iuse =(isnan(xs)~=1) & (isnan(ys)~=1) & (isnan(ws)~=1);
        x = xs(iuse); y = ys(iuse); w = ws(iuse);
    end


    if (length(x)~= length(y)) ||(length(x)~= length(w))
        error('dont be silly! x, y and w should be same length');

    elseif (length(x)<=2)
        error('dont be silly! x, y and w should be longer than 2');
    end
    %x = reshape(x,length(x),1);
    %y = reshape(y,length(y),1);
    %w = reshape(w,length(w),1);
    n = length(x);
    % mx = mean(x);
    % my = mean(y);
    xmat = ones(n,2);
    xmat(:,2) = x;
    xmatT = transpose(xmat);
    % vmat is matrix with all zeros except diagonal is 1/weight
    vmat=zeros(n,n);
    for i=1:n; vmat(i,i)=1/w(i); end
    resmat=inv(xmatT*inv(vmat)*xmat)*xmatT*inv(vmat)*y;
%     resmat=pinv(xmatT*pinv(vmat)*xmat)*xmatT*pinv(vmat)*y;
%     resmat = lsqminnorm(xmatT*lsqminnorm(vmat,xmat),xmatT)*lsqminnorm(vmat,y);
    % a=resmat(1);
    elasti=resmat(2);
    % ss_e_w = sum((y -a -elasti*x).^2.*w);
    % ss_yy_w = sum((y-my).^2.*w);
    % ss_xx_w = sum((x-mx).^2.*w);
    % ss_xy_w = sum((x-mx).*(y-my).*w);
    % r_w = sqrt((ss_yy_w-ss_e_w)/ss_yy_w);
    % r=r_w;
    % sigma2 = ss_e_w/(n-2);
    % seab = (sigma2*inv(xmatT*inv(vmat)*xmat)).^.5;
    % se_a = seab(1,1);
    % se_b = seab(2,2);

    % resvec = [a,elasti,r,se_a,se_b];
    %     ss_xx = sum((x-mx).^2);
    %     ss_yy = sum((y-my).^2);
    %     ss_xy = sum((x-mx).*(y-my));
    %     %b=ss_xy/ss_xx;
    %     %a = my - b*mx;
    %     r = sqrt(ss_xy^2/(ss_xx*ss_yy));
    %     %r^2
end