#Chris Nixon
#Algorithms II
#Fri. Jan. 27th, 2011
#Homework 3 Problem 2

class Select2
  def select2(select_array, t, low, high)
    if high - low + 1 <= 5
      x = ad_hoc(select_array, t)
      puts "The value in the sorted array #{x[1]} at index #{t} is #{x[0]}."
      return x[0]
    else
      puts "low: #{low} ---- high: #{high} ---- #{t}"
      puts "SELECT ARRAY: #{select_array}"
      qtemp = ((high - low + 1).to_f/5.to_f).floor
      q = qtemp
      puts "QTEMP: #{qtemp}"
      median_array = []
      a1, a2 = 0, 4
      q.times do
        median_array << median_of_five(select_array[a1..a2])
        a1 += 5
        a2 += 5
      end
      puts "MEDIAN ARRAY: #{median_array}"
      v = select2(median_array, ((qtemp-1).to_f/2.to_f).ceil, 0, qtemp - 1)
      partition = partition2(select_array, low, high, select_array.index(v))
      position = partition[0]
      puts "Position #{position} and t: #{t}"
      puts "Partition array: #{partition[1]}"
      if t == position
        x = select_array[position]
        puts "We found it: #{x}"
      elsif t < position
        select2(select_array, t, low, position - 1)
      elsif t > position
        select2(select_array, t, position + 1, high)
      end
    end
  end

  def partition2(select_array, low, high, position)
    moveright = low
    moveleft = high
    x = select_array[position]
    while( moveright < moveleft ) do
      until select_array[moveright] >= x
        moveright += 1
      end
      until select_array[moveleft] <= x
        moveleft -= 1
      end
      if moveright < moveleft
        temp = select_array[moveleft]
        select_array[moveleft] = select_array[moveright]
        select_array[moveright] = temp
      end
    end
    position = moveleft
    select_array[low] = select_array[position]
    select_array[position] = x
    return position, select_array
  end

  def median_of_five(five_array)
    if five_array[0] < five_array[1]
      temp = five_array[1]
      five_array[1] = five_array[0]
      five_array[0] = temp
    end

    if five_array[2] < five_array[3]
      temp = five_array[2]
      five_array[2] = five_array[3]
      five_array[3] = temp
    end

    if five_array[0] < five_array[2]
      temp = five_array[0]
      five_array[0] = five_array[2]
      five_array[2] = temp
      temp = five_array[1]
      five_array[1] = five_array[3]
      five_array[3] = temp
    end
  
    if five_array[1] < five_array[4]
      temp = five_array[1]
      five_array[1] = five_array[4]
      five_array[4] = temp
    end

    if five_array[1] > five_array[2]
      if five_array[2] > five_array[4]
        final = five_array[2]
      else
        final = five_array[4]
      end
    elsif five_array[1] > five_array[3]
      final = five_array[1]
    else
      final = five_array[3]
    end
    return final
  end

  def ad_hoc(select_array, t)
    return select_array.sort[t], select_array.sort
  end

  #discusses the sort2dmesh function and the complexity
  def discussion
    puts "For the sorting a 2D mesh the W(n) = sqrt(n)*log(n) + sqrt(n). EvenOddRowSort (line 23) and\nEvenOddColumnSort (line 47) each perform sqrt(n) parallel comparison steps."
    puts "The Sort2dMesh or in our case sort_mesh (line 7) function itself involes log_2_(n) + 1 steps.\nThis is how we get the worst case complexity as mentioned before."
  end
end

Select2.new.select2([12, 4, 35, 18, 36, 63, 37, 338, 2, 3, 11, 22, 133, 1, 10, 126, 17, 1888, 129, 2540, 213, 23, 12, 7, 252], 5, 0, 24)
