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

result = input.gsub(/^(\s*?)```(\w+)?\n(.*?)```(\s*?)$/m) do |m|
    prepand_space = $1
    lang = acceptable_code($2)
    code = $3
    postpand_space = $4
    is_empty_block = m.match(/^(\s*?)```\s*```(\s*?)$/m)
    if (!is_empty_block || (is_empty_block && is_empty_block[0] != m))   # skip empty block
        lines = code.split("\n").length
        opts = ' gutter="true"' if lines > 1 && lang != 'bash'
        "#{prepand_space}[#{lang}#{opts}]\n#{code}[/#{lang}]#{postpand_space}"
    else
        m
    end
end

print result