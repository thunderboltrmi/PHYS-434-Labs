function massCut2(h,q,hLambda,qLambda)


% hTransverseMomentumDist=fitdist(higg1(1,:)',"Poisson");
% qTransverseMomentumDist=fitdist(qcd1(1,:)',"Poisson");

nHiggs = 100;
nQCD = 2000;

hDist=fitdist(h',"Poisson");
qDist=fitdist(q',"Poisson");
% hDistLambda = 446
% qLambda = 483

% t = 0;
% funct = @(t,a,b) (a*(cdf(hDist,hLambda-t)-cdf(qDist, qLambda-t)))/(sqrt(b*abs(cdf(qDist,qLambda-t)-cdf(qDist,qLambda+t))));
% clear currentRatio;
t = 0.1;
hEvents = 0;
qEvents = 0;
for i=1:100000
        if (h(i)>=hLambda-t)&&(h(i)<=hLambda+t)
            hEvents = hEvents+1;
        end
        
        if (q(i)>=qLambda-t)&&(h(i)<=qLambda+t)
            qEvents = qEvents+1;
        end
end
    
    cut = t;
    ratio = 100*hEvents/sqrt(20000*qEvents);
    maxRatio = ratio;

for t = .2:.1:100
    
    hEvents = 0;
    qEvents = 0;
    
    for i=1:100000
        if (h(i)>=hLambda-t)&&(h(i)<=hLambda+t)
            hEvents = hEvents+1;
        end
        
        if (q(i)>=qLambda-t)&&(h(i)<=qLambda+t)
            qEvents = qEvents+1;
        end
    end
    
    ratio = 100*hEvents/sqrt(20000*qEvents);
    
    if ratio > maxRatio
        maxRatio = ratio;
        cut = t;
    end
end

ratio
cut



















% initialRatio = nHiggs/sqrt(nQCD)
% for t = 1:0.1:100
%     for(
%     currentRatio = funct(t,a,b);
%     difference = abs(funct(t+.1,a,b)-currentRatio);
%     currentRatio = funct(t);
%     if difference<0.00000000000000000000000000000000000000000000000000000001
%         cut = t;
%         break
%     end
% end
% cut
% currentRatio 
% 
h(h<hLambda-cut) = [];
h(h>hLambda+cut) = [];
q(q<hLambda-cut) = [];
q(q>hLambda+cut) = [];

histogram(h,100,"Normalization", "Probability",'FaceColor',[0,.4,.8],'FaceAlpha',0.5)
hold on;
histogram(q,100,"Normalization", "Probability",'FaceColor',[1,1,.1],'FaceAlpha',0.3)
hold off;

end

