function [root,info] = modifiedbrent3035418130(func,Int,params)
root_tol = params.root_tol;
func_tol = params.func_tol;
maxit = params.maxit;
a = Int.a;
b = Int.b;
f_a = func(a); f_b = func(b);

if (f_a*f_b) >= 0
    root =inf;
    info.flag= 1;
    return;
end
info.flag = 0;
if (f_a < f_b)
    c=a;
    a=b;
    b=c;
end

c=a;
succ = [0 0 0 0 0];
bi_int = abs(b-a);
prev_s=(a+b)/2;
for i = 1:maxit
    
    if (func(a) ~= func(c)) && (func(b)~=func(c))
        s = a*func(b)*func(c)/((func(a)-func(b))*(func(a)-func(c))) + b*func(a)*func(c)/((func(b)-func(a))*(func(b)-func(c))) + c*func(a)*func(b)/((func(c)-func(a))*(func(c)-func(b)));
    else
        s = b-func(b)*(b-a)/(func(b)-func(a));
    end
    
    if (((3*a+b)/4-s)*(b-s)>0)...
            || (sum(succ(end-4:end))==5 && abs(b-a) > 0.5*bi_int)...
            || (abs(func(s)) >= 0.5*abs(func(prev_s)))
        s = (a+b)/2;
        succ = [succ 0];
        bi_int = bi_int/2;
    else
        succ = [succ 1];
    end
    
    f_a = func(a); f_b = func(b);f_s = func(s);
    
    if (abs(f_s)<=func_tol)
        root = s;
        info.flag=0;
        info.iter_num=i;
        info.iterpolation=succ(6:end);
        info.interval=[a b];
        return
    end
    
    c=b;
    if f_a*f_s<0
        b=s;
        f_b=f_s;
    else
        f_a=f_s;
        a=s;
    end
    
    if abs(f_a)<abs(f_b)
        d=a;
        a=b;
        b=d;
    end
    
    if abs(b-a) <= root_tol
        root = s;
        info.flag=0;
        info.iter_num=i;
        info.iterpolation=succ(6:end);
        info.interval=[a b];
        return
    end
    
    
    pre_s=s;
end
        
info.flag= 1;
info.iterpolation=succ(6:end);
        
       
                   
end
        



