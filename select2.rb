#Chris Nixon
#Algorithms II
#Fri. Jan. 27th, 2011
#Homework 3 Problem 2

class Select2
  def select2(select_array, t, low, high)
    puts "low: #{low} ---- high: #{high} ---- #{t}"
    puts "SELECT ARRAY: #{select_array[low..high]}"
    if high - low + 1 <= 5
      x = ad_hoc(select_array, t, low, high)
      puts "ADHOC: The value in the sorted array #{x[1]} at index #{t} is #{x[0]}."
      return x[0]
    else
      median_array = []
      q = ((high - low + 1).to_f/5.to_f).floor
      qtemp = q
      a1, a2 = low, low+4
      q.times do
        median_array << median_of_five(select_array[a1..a2])
        a1 += 5
        a2 += 5
      end
      avg_median_value = nil
      remainder = 0
      if ((high - low + 1) % 5) != 0
        remainder = (high - low +1) % 5
        puts "REMAINDER: #{remainder}"
        if remainder == 1
          array_leftover = select_array.last
          median_array << array_leftover
        else
          array_leftover = select_array[select_array.length-remainder..select_array.length-1].sort
            if array_leftover.length % 2 == 0
              median_array << array_leftover[array_leftover.length/2]
            else
              avg_median_value = array_leftover[((array_leftover.length+1)/2)-1]
              median_array << avg_median_value
            end
        end
        puts "LEFTOVER: #{array_leftover}"
      end
      puts "MEDIAN ARRAY: #{median_array}"
      pivot = select2(median_array, (qtemp-1)/2, 0, qtemp - 1)
      puts "PIVOT: #{pivot}"
      puts "INDEX OF PIVOT: #{select_array.index(pivot)}"
      index_pivot = select_array.index(pivot)
      temp = select_array[low]
      select_array[low] = select_array[index_pivot]
      select_array[index_pivot] = temp
      puts "Modified select array: #{select_array}"
      partition = partition2(select_array, low, high)
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

  def partition2(select_array, low, high)
    moveright = low
    moveleft = high
    x = select_array[low]
    while( moveright < moveleft ) do
      until select_array[moveright] >= x do
        moveright += 1
      end
      until select_array[moveleft] <= x do
        moveleft -= 1
      end
      if moveright < moveleft
        temp = select_array[moveleft]
        select_array[moveleft] = select_array[moveright]
        select_array[moveright] = temp
      end
    end
    puts "MIDSTPARTION: #{select_array}"
    position = moveleft
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

  def ad_hoc(select_array, t, low, high)
    if high-low+1 == 5 && t <= 4
      return select_array[low..high].sort[t], select_array[low..high].sort
    else
      if select_array[low..high].length % 2 != 0
        return select_array[low..high].sort[t-low], select_array[low..high].sort
      else
        return select_array[low..high].sort[t-low], select_array[low..high].sort
      end
    end
  end
end

Select2.new.select2([12, 4, 35, 18, 36, 63, 37, 338, 2, 3, 7, 22, 55, 13, 15, 33, 14, 99, 1222, 1, 5], 12, 0, 20)
