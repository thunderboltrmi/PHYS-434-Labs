function [ratios, cut, h, q] = massCut2(h,q,hLambda,qLambda)
nHiggs = 100;
nQCD = 20007;
t = 0.1;
hEvents = 0;
qEvents = 0;

hNewLength = length(h);
qNewLength = length(q);

for i=1:hNewLength
        if (h(i)>=hLambda-t)&&(h(i)<=hLambda+t)
            hEvents = hEvents+1;
        end
end
for i=1:qNewLength
        if (q(i)>=qLambda-t)&&(q(i)<=qLambda+t)
            qEvents = qEvents+1;
        end
end
    
    cut = t;
    ratio = nHiggs*hEvents/sqrt(nQCD*qEvents);
    maxRatio = ratio;

    ratios(1) = ratio;
for t = .2:.1:100
    
    hEvents = 0;
    qEvents = 0;
    
    for i=1:hNewLength
        if (h(i)>=hLambda-t)&&(h(i)<=hLambda+t)
            hEvents = hEvents+1;
        end
    end
    for i=1:qNewLength
        if (q(i)>=qLambda-t)&&(q(i)<=qLambda+t)
            qEvents = qEvents+1;
        end
    end
    
    ratio = nHiggs*hEvents/sqrt(nQCD*qEvents);
    ratios(floor(t*10)) = ratio;
    
    if ratio > maxRatio
        maxRatio = ratio;
        cut = t;
    end
end


ratio
cut

h(h<hLambda-cut) = [];
h(h>hLambda+cut) = [];
q(q<hLambda-cut) = [];
q(q>hLambda+cut) = [];

histogram(h,100,"Normalization", "Probability",'FaceColor',[0,.4,.8],'FaceAlpha',0.5)
hold on;
histogram(q,100,"Normalization", "Probability",'FaceColor',[1,1,.1],'FaceAlpha',0.3)
hold off;
end

