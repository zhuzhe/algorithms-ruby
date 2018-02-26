# 分治归并排序


# 分治归并排序的子程序，将arr[p, q]和arr[q+1, r]，排序放入一个数组
# arr[p, q]和arr[q+1, r]是已经排好序的子数组
# return arr 排好序的输入数组
def _merge(arr, p, q, r)
	left = arr[p..q]
	left << Float::INFINITY
	right = arr[(q+1)..r]
	right << Float::INFINITY
	left_index = 0
	right_index = 0
	(p..r).each do |index|
		if left[left_index] <= right[right_index]
			arr[index] = left[left_index]
			left_index += 1
		else
			arr[index] = right[right_index]
			right_index += 1
		end
	end
	arr
end

# params arr 需要排序的数组
# return arr 排好序的数组
def sort(arr, p, r)
	if p < r
		q = ((p + r) / 2).floor()
		sort(arr, p, q)
		sort(arr, q + 1, r)
		_merge(arr, p, q, r)
	end
end

p _merge([1,2,3,100,10,11], 0, 3, 5)

p sort([2,5,46,7,452], 0, 4)
