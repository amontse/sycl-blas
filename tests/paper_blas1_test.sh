cp paper_blas1_test.cpp copy.txt
for var in 001 002 004 008 016 032 064 128 256 512 ; do
  echo "LOCALSIZE=$var"
  cat copy.txt | sed "s: :\\\:g" > aux.txt
  for line in `cat aux.txt` ; do
    num=`echo $line | grep define | grep LOCALSIZE | wc -l `
    if [ $num -gt 0 ] ; then
      echo "#define LOCALSIZE $var"
    else
      echo $line | sed "s:\\\: :g"
    fi
  done > paper_blas1_test.cpp
#  cd ../build/tests
  cd ../build
  make 1>/dev/null 2>/dev/null 
#  COMPUTECPP_TARGET="host"./paper_blas1_test
#  cd ../../tests
  cd ../tests
################################
  cd ../benchmark
  ./testing.sh ; mv res.txt res_"$var".txt
  cd ../tests
done
mv copy.txt paper_blas1_test.cpp
