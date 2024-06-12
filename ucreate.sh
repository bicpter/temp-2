#!/bin/bash

# Kiểm tra xem có tham số được truyền vào không
if [ $# -eq 0 ]; then
    echo "Sử dụng: $0 <số-lần-chạy>"
    exit 1
fi

# Lặp lại số lần được chỉ định trong tham số
for ((i=1; i<=$1; i++)); do
    echo "Chạy Utopia lần thứ $i"
    firejail /opt/utopia/messenger/utopia &
done
