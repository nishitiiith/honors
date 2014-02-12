function theta = my_angle(p,q,base);
a = p-base;%base-p;
b = q-base;%base-q;
vala = sqrt(a(1)*a(1)+a(2)*a(2));
valb = sqrt(b(1)*b(1)+b(2)*b(2));
theta = acos(sum(a.*b)/(vala*valb))*180.0/3.14;
