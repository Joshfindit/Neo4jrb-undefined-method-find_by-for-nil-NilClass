class Integer
  def floor2(exp = 0)
   multiplier = 10 ** exp
   ((self / multiplier).floor) * multiplier
  end
end
