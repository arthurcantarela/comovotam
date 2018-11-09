pkg load io;
[num, _resto] = xlsread("votos.xlsx", "votos");

votos = num(:,1);
meio = num(:,4);
tentou = num(:,5);
reeleito = num(:,6);

partidos = _resto(2:n,3);
_partidos = unique(partidos);
[npartidos, _aux] = size(_partidos);

ufs = _resto(2:n,4);
_ufs = unique(ufs);
[nufs, _aux] = size(_ufs);

figure(1);
hold on;
partidosfavor = partidoscontra = zeros(npartidos, 1);
_meiofavor = _meiocontra = zeros(npartidos, 1);
_tentoufavor = _tentoucontra = zeros(npartidos, 1);
_reeleitofavor = _reeleitocontra = zeros(npartidos, 1);
for i = 1:npartidos
  favor = contra = 0;
  meiofavor = meiocontra = 0;
  tentoufavor = tentoucontra = 0;
  reeleitofavor = reeleitocontra = 0;
  for j = 1:n-1
    if(strcmp(cell2mat(_partidos(i)), cell2mat(partidos(j))))
      if(votos(j))
        favor--;
        if(meio(j))
          meiofavor--;
        elseif(tentou(j))
          tentoufavor--;
          if(reeleito(j))
            reeleitofavor--;
          endif
        endif
      else
        contra++;
        if(meio(j))
          meiocontra++;
        elseif(tentou(j))
          tentoucontra++;
          if(reeleito(j))
            reeleitocontra++;
          endif
        endif
      endif
    endif
  endfor
  partidosfavor(i) = favor;
  partidoscontra(i) = contra;
  
  _meiofavor(i) = meiofavor;
  _meiocontra(i) = meiocontra;
  
  _tentoufavor(i) = tentoufavor;
  _tentoucontra(i) = tentoucontra;
  
  _reeleitofavor(i) = reeleitofavor;
  _reeleitocontra(i) = reeleitocontra;
  
endfor
total = abs(partidoscontra)+abs(partidosfavor);
[total, ordem] = sort(total, "descend");
partidoscontra = partidoscontra(ordem, :);
partidosfavor = partidosfavor(ordem, :);
_partidos = _partidos(ordem, :);
  _meiofavor = _meiofavor(ordem, :);
  _meiocontra = _meiocontra(ordem, :);
  _tentoufavor = _tentoufavor(ordem, :);
  _tentoucontra = _tentoucontra(ordem, :);
  _reeleitofavor = _reeleitofavor(ordem, :);
  _reeleitocontra = _reeleitocontra(ordem, :);

relacao = abs(partidosfavor)./total;
[_aux, ordem] = sort(relacao);
partidoscontra = partidoscontra(ordem, :);
partidosfavor = partidosfavor(ordem, :);
_partidos = _partidos(ordem, :);
  _meiofavor = _meiofavor(ordem, :);
  _meiocontra = _meiocontra(ordem, :);
  _tentoufavor = _tentoufavor(ordem, :);
  _tentoucontra = _tentoucontra(ordem, :);
  _reeleitofavor = _reeleitofavor(ordem, :);
  _reeleitocontra = _reeleitocontra(ordem, :);

red = [255, 102, 102]/255;
darkRed = red/1.5;
lightRed = min(red*1.2, 1);
bar(partidosfavor, "facecolor", min(1, lightRed*1.5), "edgecolor", min(1, lightRed*1.5), "hist");
text(1:length(partidosfavor),partidosfavor,num2str(-1*(partidosfavor-1)-1), 'verticalalignment','top','horizontalalignment','center'); 
bar(_meiofavor+_tentoufavor, "facecolor", min(1, lightRed*1.25), "edgecolor", min(1, lightRed*1.25), "hist");
bar(_meiofavor+_reeleitofavor, "facecolor", darkRed, "edgecolor", darkRed, "hist");
bar(_reeleitofavor, "facecolor", darkRed/2, "edgecolor", darkRed/2, "hist");

blue = [51, 122, 183]/255;
darkBlue = blue/1.5;
lightBlue = min(blue*1.2, 1);
bar(partidoscontra+1, "facecolor", min(1, lightBlue*1.5), "edgecolor", min(1, lightBlue*1.5), "hist");
text(1:length(partidoscontra),partidoscontra+1,num2str(partidoscontra),'verticalalignment','bottom','horizontalalignment','center'); 
bar(_meiocontra+_tentoucontra+1, "facecolor", min(1, lightBlue*1.25), "edgecolor", min(1, lightBlue*1.25), "hist");
bar(_meiocontra+_reeleitocontra+1, "facecolor", darkBlue, "edgecolor", darkBlue, "hist");
bar(_reeleitocontra+1, "facecolor", darkBlue/2, "edgecolor", darkBlue/2, "hist");

bar(ones(npartidos,1),"w", "hist");
text(1:npartidos,zeros(npartidos, 1)+.2,_partidos,'verticalalignment','bottom','horizontalalignment','center'); 

l = legend(
  "Favor, fim do mandato",
  "Favor, não conseguiu se reeleger",
  "Favor, meio do mandato",
  "Favor, reeleito(a)",
  "Contra, fim do mandato",
  "Contra, não conseguiu se reeleger",
  "Contra, meio do mandato",
  "Contra, reeleito(a)"
);

legend(l, "location", "southoutside");
title("Votos dos senadores pelo aumento do STF por partido");
axis off;
hold off;