function lable=get_labe2(str1)

p1=strfind(str1, 'alpha+beta');
temp=p1{:,:};
if temp~=0
    lable=4;return;
end
p2=strfind(str1, 'alpha/beta');
temp=p2{:,:};
if temp~=0~=0
    lable=3;return;
end
p3=strfind(str1, 'alpha');
temp=p3{:,:};
if temp~=0~=0
    lable=1;return;
end
p4=strfind(str1, 'beta');
temp=p4{:,:};
if temp~=0~=0
    lable=2;return;
end
