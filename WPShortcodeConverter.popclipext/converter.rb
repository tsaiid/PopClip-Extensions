#!/usr/bin/env ruby
#input = ARGF.read
input = ENV['POPCLIP_TEXT']

def acceptable_code(lang)
    available_lang = ['actionscript3',
                      'bash',
                      'clojure',
                      'coldfusion',
                      'cpp',
                      'csharp',
                      'css',
                      'delphi',
                      'erlang',
                      'fsharp',
                      'diff',
                      'groovy',
                      'html',
                      'javascript',
                      'java',
                      'javafx',
                      'matlab',
                      'objc',
                      'perl',
                      'php',
                      'text',
                      'powershell',
                      'python',
                      'r',
                      'ruby',
                      'scala',
                      'sql',
                      'vb',
                      'xml']
    available_lang.include?(lang) ? lang : "code"
end

result = input.gsub(/```(\w+)?\n(.+?)```/m) do |m|
    lang = acceptable_code($1)
    code = $2
    is_empty_block = m.match(/^```\s+```$/m)
    if (!is_empty_block || (is_empty_block && is_empty_block[0] != m))   # skip empty block
        lines = code.split("\n").length
        opts = ' gutter="true"' if lines > 1 && lang != 'bash'
        "[#{lang}#{opts}]\n#{code}[/#{lang}]"
    end
end

print result