#!/bin/bash 

# Kiểm tra xem có tham số được truyền vào không
if [ $# -eq 0 ]; then
    echo "Sử dụng: $0 <số-lần-chạy>"
    exit 1
fi

# Kiểm tra xem tham số có phải là số nguyên không
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Tham số phải là một số nguyên dương."
    exit 1
fi

# Đường dẫn thư mục bên ngoài cần chia sẻ
SOURCE_DIR="/root/.local/1/"

# Tạo thư mục tạm thời chung
TEMP_DIR="/tmp/shared_temp"
mkdir -p $TEMP_DIR

# Sao chép các tệp vào thư mục tạm thời
cp -r $SOURCE_DIR* $TEMP_DIR

# Lặp lại số lần được chỉ định trong tham số
for ((i=1; i<=$1; i++)); do
    echo "Chạy Utopia lần thứ $i"

    # Chạy ứng dụng trong môi trường firejail với thư mục tạm thời
    # Sử dụng nohup để không bị dừng khi script chính bị dừng
    nohup firejail --private=$TEMP_DIR /opt/utopia/messenger/utopia > /dev/null 2>&1 &
done

# Đợi tất cả các quá trình con hoàn thành
wait
