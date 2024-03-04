

# w3m http://openinsider.com/ | sed -n "/ X    F/,/A  Amended filing/p"
cat logo.txt
w3m http://openinsider.com/ps_data.csv | cat > graph
cat graph | awk '{print $2}' | tail -n+4000 > BuyN
cat graph | awk '{print $3}' | tail -n+4000 > SellN
cat graph | awk '{print $4}' | tail -n+4000 > BuyM
cat graph | awk '{print $5}' | tail -n+4000 > SellM
cat graph | awk '{print $1}' | tail -n+4000 > Time
./Jolly > Timeseries.csv
python3 ReadTimeSeries.py


set style fill transparent solid 0.6
gnuplot -p -e "plot 'SellM' with filledcurves  above y1=0, 'BuyM' with filledcurves  above y1=0  lc rgb  '#00ffff'"
gnuplot -p -e "plot 'SellN' with filledcurves  above y1=0, 'BuyN' with filledcurves  above y1=0  lc rgb  '#00ffff'"
gnuplot -p -e "plot 'A.txt' with lines, 'B.txt' with filledcurves  above y1=0  lc rgb  '#00ffff'"

w3m http://openinsider.com/latest-insider-trading | cat | sed -n "/"$(date +%Y-%m)"/p" | grep 'P -' > NewDay
w3m http://openinsider.com/latest-insider-trading | cat | sed -n "/"$(date +%Y-%m)"/p" | grep 'S -' >> NewDay

#   dialog --title "P&S Today" --textbox NewDay 100 222

cat NewDay
