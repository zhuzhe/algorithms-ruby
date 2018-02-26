# 找到最大子数组算法
# 分治法

def find_cross_sub_array(arr, low, mid, high)
	# 找到左边数组arr[i..mid]的最大子数组
	max_left = -Float::INFINITY
	i = mid
	left_low = mid
	count = 0
	while i >= low - 1
		count = count + arr[i]
		if count >= max_left
			max_left = count
			left_low = i
		end
		i -= 1		
	end
	# 找到右边数组arr[mid+1..j]的最大子数组
	max_right = -Float::INFINITY
	j = mid + 1
	right_high = j
	count = 0
	while (j <= high)
		count = count + arr[j]
		if count >= max_right
			max_right = count
			right_high = j
			p right_high
		end
		j += 1
	end
	# 合并arr[i..mid]和arr[mid+1..j]就是跨越中点的最大子数组
	[left_low, right_high, arr[left_low..mid].concat(arr[(mid + 1)..right_high]).sum]
end

def find_sub_array(arr, i, j)
	if i == j
		return [i, j, arr[i]] 
	end
	mid = ((i + j) / 2).floor
	left_low, left_high, left_sum = find_sub_array(arr, i, mid)
	right_low, right_high, right_sum = find_sub_array(arr, mid + 1, j)
	cross_low, cross_high, cross_sum = find_cross_sub_array(arr, i, mid, j)
	
	if left_sum >= right_sum and left_sum >= cross_sum
		return [left_low, left_high, left_sum]
	elsif right_sum >= left_sum and right_sum >= cross_sum
		return [right_low, right_high, right_sum]
	else
		return [cross_low, cross_high, cross_sum]
	end
end

p find_sub_array([13,-3,-25,20,-3,-16,-23,18,20,-7,12,-5,-22,15,-4,7], 0, [13,-3,-25,20,-3,-16,-23,18,20,-7,12,-5,-22,15,-4,7].length - 1)


