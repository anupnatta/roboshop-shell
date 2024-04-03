code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f {log_file}

print_head() {
  echo -e "\e[34m$1\e[0m"
}
-->status_check() {
  if [$1 -eq 0]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
  fi
}
-->!