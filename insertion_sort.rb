# 插入排序算法描述

# 输入: n个数的一个序列{a1, a2, .... an}.
# 输出: 输入序列的一个排列{a1`, a2`, ... an`}



# ruby版的插入排序实现
# params arr 需要排序的数组，元素为数字
# return arr 排好序的arr
# ！此方法会改变输入数组参数

def sort!(arr)
	arr.each_with_index do |elem, index|
		# 从第二个元素开始取出比较
		next if index == 0
		# 将需要比较的元素放入临时变量，避免覆盖
		key = elem
		# i是与之比较的子数组最大index
		i = index - 1
		# 将elem与子数组的元素从右到左比较，如果elem大则往arr数组后移
		while i >= 0 and arr[i] > elem
			arr[i + 1] = arr[i]
			i -= 1
		end
		# 将elem插入进子数组中
		arr[i + 1] = elem
	end	
	arr
end

# 测试
p sort!([6,4,5])