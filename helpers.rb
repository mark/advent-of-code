class Array

  def window(size)
    enumerator = Enumerator.new do |y|
      (length-size+1).times do |i|
        y.yield(*self[i,size])
      end
    end

    if block_given?
      enumerator.each { |args| yield(*args) }
      self
    else
      enumerator
    end
  end

end
