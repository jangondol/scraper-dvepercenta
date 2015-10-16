sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install git
# #todo -- consider installing released (stable) versions, not the latest (unknown) versions from HEAD
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
# rbenv doesn't work with sudo by default (we need "sudo jruby"), rbenv-sudo plugin is needed  for this

# jruby installation requires java + build tools (fyi: #debianpackage:default-jdk likely not needed)
sudo apt-get install -y default-jre
sudo apt-get install -y build-essential
# ~/.rbenv/bin/rbenv install --list
# fyi: sudo is required for install command
sudo ~/.rbenv/bin/rbenv install jruby-1.7.22
# ~/.rbenv/bin/rbenv versions
eval "$(~/.rbenv/bin/rbenv init -)"
~/.rbenv/bin/rbenv global jruby-1.7.22
# ~/.rbenv/bin/rbenv version
# jruby --version
~/.rbenv/bin/rbenv sudo jruby -S gem install tabula-extractor

mkdir -p /vagrant/data
cd /vagrant/data

# https://www.financnasprava.sk/sk/elektronicke-sluzby/verejne-sluzby/zoznamy/zoznam-prijimatelov-dane
# http://rozhodni.sk/prijimatel/databazy/

wget -O 2014.pdf https://web.archive.org/web/20150326150626/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/2015.01.28_roc_prehlad_prij_2014.pdf
wget -O 2013.pdf https://web.archive.org/web/20150326090847/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/rocny_prehlad_prijimatelov_2013.pdf
# alternative URL: https://web.archive.org/web/20150226152338/http://rozhodni.sk/wp-content/uploads/2014/02/rocny_prehlad_prijimatelov_2013.pdf
# alternative URL: https://web.archive.org/web/20150326101405/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/roc_prehlad_prij_2012.pdf
wget -O 2011.pdf https://web.archive.org/web/20150326085813/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/roc_prehlad_prij_2011.pdf
# alternative URL: https://web.archive.org/web/20150226152332/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_11.pdf
wget -O 2010.pdf https://web.archive.org/web/20150326091607/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/roc_prehlad_prij_2010.pdf
# alternative URL: https://web.archive.org/web/20150226152328/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_10.pdf
wget -O 2009.pdf https://web.archive.org/web/20150326093928/https://www.financnasprava.sk/_img/pfsedit/Dokumenty_PFS/Zoznamy/Prijimatelia_dane/roc_prehlad_prij_2009.pdf
# alternative URL: https://web.archive.org/web/20150226152323/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_09.pdf
wget -O 2008.pdf https://web.archive.org/web/20150226152318/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_08.pdf
wget -O 2003.pdf https://web.archive.org/web/20150226152314/http://rozhodni.sk/wp-content/uploads/2012/12/prij_03.pdf
wget -O 2002.pdf https://web.archive.org/web/20150226152255/http://rozhodni.sk/wp-content/uploads/2012/12/prij_02.pdf

wget -O _2012.xls https://web.archive.org/web/20140520151232/http://rozhodni.sk/wp-content/uploads/2013/02/Vysledky2percenta2012.xls
wget -O _2007.xls https://web.archive.org/web/20140520151134/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_07.xls
wget -O _2006.xls https://web.archive.org/web/20140520151124/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_06.xls
wget -O _2005.xls https://web.archive.org/web/20140520151118/http://rozhodni.sk/wp-content/uploads/2012/12/roc_prehlad_05.xls
wget -O _2004.xls https://web.archive.org/web/20140520151111/http://rozhodni.sk/wp-content/uploads/2012/12/prij_d04.xls

tabula 2014.pdf -o 2014-raw.csv --pages 1-9999 --spreadsheet
tabula 2013.pdf -o 2013-raw.csv --pages 1-9999 --spreadsheet
tabula 2011.pdf -o 2011-raw.csv --pages 1-9999 --spreadsheet
tabula 2010.pdf -o 2010-raw.csv --pages 1-9999 --spreadsheet
tabula 2009.pdf -o 2009-raw.csv --pages 1-9999 --spreadsheet
tabula 2008.pdf -o 2008-raw.csv --pages 1-9999 --spreadsheet
tabula 2003.pdf -o 2003-raw.csv --pages 1-9999 --spreadsheet
tabula 2002.pdf -o 2002-raw.csv --pages 1-9999 --spreadsheet

cat 2014-raw.csv | grep -v "Názov prijímateľa" | grep -v "Ročný prehľad" > 2014-final.csv
cat 2013-raw.csv | grep -v "Názov prijímateľa" | grep -v "Ročný prehľad" > 2013-final.csv
cat 2011-raw.csv | grep -v "Názov prijímateľa" > 2011-final.csv
cat 2010-raw.csv | grep -v "Názov prijímateľa" > 2010-final.csv
cat 2009-raw.csv | grep -v "Názov prijímateľa" > 2009-final.csv
cat 2008-raw.csv | grep -v "Názov prijímateľa" > 2008-final.csv
cat 2003-raw.csv | grep -v "Názov prijímateľa" > 2003-final.csv
cat 2002-raw.csv > 2002-final.csv
