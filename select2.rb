#Chris Nixon
#Algorithms II
#Fri. Jan. 27th, 2011
#Homework 3 Problem 2

class Select2
  def select2(select_array, t, low, high)
    remainder = 0
    median_array = []
    puts "low: #{low} ---- high: #{high} ---- index: #{t}"
    puts "SELECT ARRAY: #{select_array}"
    if high - low + 1 <= 5
      x = ad_hoc(select_array, t, low, high) #calls the ad_hoc method which gets the element at t-low in a sorted list
      puts "ADHOC: The value in the sorted array #{x[1]} at index #{t} is #{x[0]}."
      return x[0]
    end
    q = ((high - low + 1).to_f/5.to_f).floor
    a1, a2 = low, low+4
    q.times do
      median_array << median_of_five(select_array[a1..a2]) #calls the median_of_five method given to use by Dr. Ralescu implemented in ruby
      a1 += 5
      a2 += 5
    end
    if ((high - low + 1) % 5) != 0 #if there are elements not in a group of five get the remainder then do an adhoc approach to get the median
      remainder = (high - low +1) % 5
      if remainder == 1
        median_array << select_array.last
      else
        array_leftover = select_array[select_array.length-remainder..select_array.length-1].sort
        if array_leftover.length % 2 == 0 #checks for even amount of values
          median_array << array_leftover[array_leftover.length/2]
        else
          median_array << array_leftover[((array_leftover.length-1)/2)]
        end
      end
      q += 1 #necessary when we append the median from the overflow elements not in a group of 5
    end
    puts "median of medians array: #{median_array}"
    pivot = select2(median_array, (q-1)/2, 0, q-1) #make a recursive call to select2 in order to get the pseudomedian value
    puts "Pivot value from median of medians: #{pivot}"
    index_pivot = select_array.index(pivot) #get the index of the pivot element to be used
    temp = select_array[low] #swap the value at the low index with the value at the pivot index
    select_array[low] = select_array[index_pivot]
    select_array[index_pivot] = temp
    partition = partition2(select_array, low, high) #call partition using the first element in the array (pivot value)
    position = partition[0]
    puts "Position: #{position} and t: #{t}"
    puts "Partition array: #{partition[1]}"
    if t == position
      x = select_array[position]
      puts "The position from the parition is equal to your input of the index: The element at index #{t} is #{x}"
    elsif t < position
      select2(select_array, t, low, position - 1) #make a recursive call where the value we are looking for is in the portion of the array less than the pivot
    elsif t > position
      select2(select_array, t, position + 1, high) #make a recursive call where the value we are looking for is in the portion of the array higher than the pivot
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
      if select_array[moveright] == select_array[moveleft] #in case of repeated elements continue to increment moveright
        moveright += 1
      end
      if moveright < moveleft
        temp = select_array[moveleft]
        select_array[moveleft] = select_array[moveright]
        select_array[moveright] = temp
      end
    end
    position = moveleft
    return position, select_array
  end

  def median_of_five(five_array) #copied from matlab code give to us by Dr. Ralescu
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
    if select_array[low..high].length % 2 != 0
      return select_array[low..high].sort[t-low], select_array[low..high].sort
    else
      return select_array[low..high].sort[t-low], select_array[low..high].sort
    end
  end

  #Validates the string is an integer from user input
  def is_int?(string)
    !!(string =~ /^[-+]?[0-9]+$/)
  end
end

  array = Array.new
  while array[0].nil?
  puts "Your array is currently empty. Time to fill up."
  num = nil
    while (num != "done")
    puts "Please input element by element the array of your desire, starting with index 0 and must be an integer. The array should have at least one element. When finished building your array type 'done'"
    num = gets.chomp
    if num == "done"
      puts "Final array: #{array}"
      num = "done"
    else
      bool = Select2.new.is_int?(num)
        while (bool == false)
          puts "That was an invalid integer. Try again."
          num = gets.chomp
          bool = Select2.new.is_int?(num)
        end
        array << num.to_i
        puts "Current array: #{array} with length: #{array.length}"
        num = array.last
      end
    end
  end

  #This receives the input from the user for the input t in the Select2 code in the book
  puts "Input a valid integer for the index to find the kth smallest element in the array, between 0 and #{array.length-1} for the array: #{array}"
  num = gets.chomp
  #Validate user input
  bool = Select2.new.is_int?(num)
  while ((bool == false) || (num.to_i < 0) || (num.to_i >= array.length))
    puts "That was an invalid integer. Try again."
    puts "Input an integer between 0 and #{array.length-1} for the list: #{array}"
    num = gets.chomp
    bool = Select2.new.is_int?(num)
  end
  index = num.to_i

Select2.new.select2(array, index, 0, array.length-1)
