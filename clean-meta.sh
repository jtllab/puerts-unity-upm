#!/bin/bash

set -e

# 定义你要检查的目录
DIRECTORY="package"

# 遍历目录中的所有 .meta 文件
find "$DIRECTORY" -type f -name "*.meta" | while read -r meta_file; do
    # 对应的文件或文件夹路径
    corresponding_file="${meta_file%.meta}"

    # 检查是否存在对应的文件或文件夹
    if [ ! -e "$corresponding_file" ]; then
        echo "Removing: $meta_file"
        rm "$meta_file"
    fi
done

# 定义你要检查的目录
ERROR_FOUND=0

# 遍历目录中的所有文件和文件夹
find "$DIRECTORY" -type f -o -type d | while read -r item; do
    # 跳过 .meta 文件本身
    if [[ "$item" == *.meta ]]; then
        continue
    fi

    # 对应的 .meta 文件路径
    meta_file="${item}.meta"

    # 检查是否存在对应的 .meta 文件
    if [ ! -e "$meta_file" ]; then
        echo "Error: Corresponding .meta file not found for $item"
        ERROR_FOUND=1
    fi
done

# 根据错误状态码退出
if [ $ERROR_FOUND -eq 1 ]; then
    exit 1
else
    echo "All files and directories have corresponding .meta files."
    exit 0
fi
