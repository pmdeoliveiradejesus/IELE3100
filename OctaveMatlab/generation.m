function [zgabc,ygabcn,zg012] = generation(db)
MVAsc3=db(23); %MVASsc 3phase
MVAsc1=db(24); %MVASsc 1phase
alpha=db(25); %R1/X1
beta=db(26); %R0/X0
kVLL=db(27); %Nominal voltage (kV)
Rg1=db(28) ;%substation ground mat resistance (ohms)
Z1m=(kVLL)^2/MVAsc3;
R1=Z1m/sqrt(1+alpha^2);
X1=alpha*R1;
Z1=complex(R1,X1);% positive sequence impedance
gamma=3*(kVLL)^2/MVAsc1;
a=beta^2+1;
b=4*R1+4*beta*X1;
c=4*R1^2+4*X1^2-gamma^2;
R0=(-b+sqrt(b^2-4*a*c))/(2*a);% ohms
R02=(-b-sqrt(b^2-4*a*c))/(2*a);% ohms
X0=beta*R0;% ohms
Z0=complex(R0,X0);% ohms
a=-0.5+j*sqrt(3)*.5;
As=[1 1 1;1 a^2 a; 1 a a^2];
zg012=diag([Z0;Z1;Z1]);% ohms
zgabc=(As)*diag([Z0;Z1;Z1])*inv(As);% ohms
ygabcn=inv(zgabc);% siemens
ygabcn(4,1)=-ygabcn(1,1);% siemens
ygabcn(4,2)=-ygabcn(2,2);% siemens
ygabcn(4,3)=-ygabcn(3,3);% siemens
ygabcn(1,4)=-ygabcn(1,1);% siemens
ygabcn(2,4)=-ygabcn(2,2);% siemens
ygabcn(3,4)=-ygabcn(3,3);% siemens
ygabcn(4,4)=inv(Rg1)-ygabcn(4,1)-ygabcn(4,2)-ygabcn(4,3);% siemens 
end