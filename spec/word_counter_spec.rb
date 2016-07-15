require 'word_counter'

describe WordCounter::Base do
  def count_words(filepath)
    WordCounter::Base.new(filepath).words_count
  end
  it "should count words in doc file" do
    words = count_words('spec/test_files/docx/doc_test.doc')
    expect(words).to eq 10138
  end

  it "should count words in docx file" do
    words = count_words('spec/test_files/docx/docx_test.docx')
    expect(words).to eq 150972
  end

  it "should count words in pdf file" do
    words = count_words('spec/test_files/pdf/pdf_test.pdf')
    expect(words).to eq 10138
  end

  it "should count words in rtf file" do
    words = count_words('spec/test_files/rtf/rtf_test.rtf')
    expect(words).to eq 29790
  end

  it "should count words in txt file" do
    words = count_words('spec/test_files/txt/txt_test.txt')
    expect(words).to eq 139860
  end

  it "should count words in xlsx file" do
    words = count_words('spec/test_files/xlsx/xlsx_test.xlsx')
    expect(words).to eq 4
  end

  it "should count words in chineese txt file" do
    words = count_words('spec/test_files/txt/txt_chineese_test.txt')
    expect(words).to eq 3
  end
end
