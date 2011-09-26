require 'rjb'

Rjb::load('stanford-postagger.jar:stanford-ner.jar', ['-Xmx200m'])
CRFClassifier = Rjb::import('edu.stanford.nlp.ie.crf.CRFClassifier')

module Extract

  def self.classifier
    @classifier ||= CRFClassifier.getClassifierNoExceptions("ner-eng-ie.crf-4-conll.ser.gz")
  end

  def self.match(tag)
    if tag =~ /.+\/(ORGANIZATION|LOCATION|PERSON)/
      type = $1
      {:text => "#{tag.gsub(/\/#{type}/, '')}", :type => type}
    end
  end

  def self.parse(tagged)
    entities = []
    tokens   = tagged.split(" ")

    while tokens.size > 0
      current = match(tokens.shift)


      if current

        entities.push(current)
        peek = match(tokens[0])
        while peek && peek[:type] == current[:type]
          entities.last[:text] = entities.last[:text] + " " + peek[:text]
          tokens.shift
          peek = match(tokens[0])
        end

      end

    end

    entities
  end

  def self.extract(txt)
    raw = classifier.testString(txt)
    parse(raw)
  end

end