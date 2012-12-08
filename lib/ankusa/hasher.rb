require 'fast_stemmer'
require 'ankusa/stopwords'

module Ankusa

  class TextHash < Hash 
    attr_reader :word_count

    def initialize(text=nil, stem=true)
      super 0
      @word_count = 0
      @stem = stem
      add_text(text) unless text.nil?
    end

    def add_text(text)
      if text.instance_of? Array
        text.each { |t| add_text t }
      else
        # replace dashes with spaces, then get rid of non-word/non-space characters, 
        # then split by space to get words
        words = atomize text
        words.each { |word| add_word(word) }
      end

      self
    end

    private

    def add_word(word)
      return unless valid_word?(word)
      @word_count += 1
      word = word.stem if @stem
      key = word.intern
      store key, fetch(key, 0)+1
    end

    def atomize(text)
      text.downcase.to_ascii.tr('-', ' ').gsub(/[^\w\s]/," ").split
    end

    # word should be only alphanum chars at this point
    def valid_word?(word)
      not (Ankusa::STOPWORDS.include?(word) || word.length < 3 || word.numeric?)
    end
  end

end
