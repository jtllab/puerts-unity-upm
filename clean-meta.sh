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
