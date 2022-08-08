

StatusCheck(){
  if [ $? -eq 0 ]; then
    echo  " sucess"
  else
    echo "failed"
    exit 1
  fi
}