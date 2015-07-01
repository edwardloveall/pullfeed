require 'active_support'
require 'active_support/core_ext/string/strip'
load 'app/services/markdown_renderer.rb'

describe MarkdownRenderer do
  describe '#to_html' do
    it 'converts markdown to html' do
      renderer = MarkdownRenderer.new(markdown)

      expect(renderer.to_html).to eq html
    end

    it 'renders smart quotes' do
      quote = %{"A fancy quote"}
      smart_html = "<p>&ldquo;A fancy quote&rdquo;</p>\n"
      renderer = MarkdownRenderer.new(quote)

      expect(renderer.to_html).to eq smart_html
    end

    it 'renders code fences' do
      renderer = MarkdownRenderer.new(code_fence)

      expect(renderer.to_html).to eq code_html
    end

    it 'renders tables' do
      renderer = MarkdownRenderer.new(table)

      expect(renderer.to_html).to eq table_html
    end

    it 'adds IDs to headers' do
      renderer = MarkdownRenderer.new('# Hello, `world`!')

      expect(renderer.to_html).to eq <<-HTML.strip_heredoc
        <h1 id="hello-world">Hello, <code>world</code>!</h1>
      HTML
    end
  end

  def markdown
    <<-MARKDOWN.strip_heredoc
    Body of the article

    * a
    * list
    * of
    * things

    [A link to rails](http://www.rubyonrails.org)
    MARKDOWN
  end

  def html
    <<-HTML.strip_heredoc
    <p>Body of the article</p>

    <ul>
    <li>a</li>
    <li>list</li>
    <li>of</li>
    <li>things</li>
    </ul>

    <p><a href="http://www.rubyonrails.org">A link to rails</a></p>
    HTML
  end

  def code_fence
    <<-MARKDOWN.strip_heredoc
    ```ruby
    def hello
      puts "hello world"
    end
    ```
    MARKDOWN
  end

  def code_html
    <<-HTML.strip_heredoc
    <pre><code class="ruby">def hello
      puts &quot;hello world&quot;
    end
    </code></pre>
    HTML
  end

  def table
    <<-MARKDOWN.strip_heredoc
    |Header 1| Header 2|
    |--------|---------|
    |Value 1 | Value 2 |
    |Value 3 | Value 4 |
    MARKDOWN
  end

  def table_html
    <<-HTML.strip_heredoc
    <table><thead>
    <tr>
    <th>Header 1</th>
    <th>Header 2</th>
    </tr>
    </thead><tbody>
    <tr>
    <td>Value 1</td>
    <td>Value 2</td>
    </tr>
    <tr>
    <td>Value 3</td>
    <td>Value 4</td>
    </tr>
    </tbody></table>
    HTML
  end
end
