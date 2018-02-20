class Game

  attr_reader :letters, :errors, :good_letters, :bad_letters, :status

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    slovo.encode('UTF-8').split("")
  end

  def next_step(bukva)
    if @letters.include?(bukva) ||
     (bukva == "е" && @letters.include?("ё")) ||
     (bukva == "ё" && @letters.include?("е")) ||
     (bukva == "и" && @letters.include?("й")) ||
     (bukva == "й" && @letters.include?("и"))
     @good_letters << bukva

       @good_letters << "е" if bukva == "е"
       @good_letters << "е" if bukva == "ё"
       @good_letters << "и" if bukva == "и"
       @good_letters << "и" if bukva == "й"

    @status = 1 if (@letters - @good_letters).empty?

    else
      @bad_letters << bukva
      @errors += 1
    end

    @status = -1 if @errors >= 7
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ''
    letter = STDIN.gets.chomp[0].downcase while letter == ''
    puts letter

    next_step(letter)
  end
end
