module RestoreFromRepository
  class File
    attr_reader :body

    REGEX_BUNDLED_WITH = /^(?<pick>(?:\r\n|\r|\n)^BUNDLED WITH.*(?:\r\n|\r|\n).+(?:\r\n|\r|\n))/

    def self.insert(text, section)
      if section && !section.empty?
        new(text + section)
      else
        new(text)
      end
    end

    def self.restore(
        data,
            target_file = Repository::TARGET_FILE,
            ref = Repository::REF,
            git_path = Repository::GIT_PATH,
            git_options = Repository::GIT_OPTIONS,
            new_line = Repository::NEW_LINE
    )
      trimmed = new(data).delete_bundled_with
      target_file_data = Repository
                           .new(git_path, git_options)
                           .fetch_file(target_file, ref, new_line)
      section = new(target_file_data)
                    .pick
      insert(trimmed.body, section)
    end

    def initialize(text)
      @body = text
    end

    # "\n\nBUNDLED WITH\n   1.10.4\n" => "\n"
    def delete_bundled_with
      self.class.new(body.sub(REGEX_BUNDLED_WITH) { '' })
    end

    def pick
      match = REGEX_BUNDLED_WITH.match(body)
      if match
        match[:pick]
      else
        ''
      end
    end

    def to_s
      body
    end

    def ==(other)
      body == other.body
    end
  end
end