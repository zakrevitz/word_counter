require 'word_counter'
require 'spec_helper'
describe WordCounter::Base do
  it "should count words in doc file" do
    word_counter = described_class.from_file('spec/test_files/docx/doc_test.doc')
    expect(word_counter.words).to eq 10138
  end

  it "should count words in docx file" do
    word_counter = described_class.from_file('spec/test_files/docx/docx_test.docx')
    expect(word_counter.words).to eq 150972
  end

  it "should count words in xml file" do
    word_counter = described_class.from_file('spec/test_files/xml/1.xml')
    expect(word_counter.words).to eq 31
  end

  it "should count words in xliff file" do
    word_counter = described_class.from_file('spec/test_files/xml/1.xliff')
    expect(word_counter.words).to eq 183
  end

  it "should count words in docx file" do
    word_counter = described_class.from_file('spec/test_files/docx/docx_test.odt')
    expect(word_counter.words).to eq 150972
  end

  it "should count words in odt file" do
    word_counter = described_class.from_file('spec/test_files/docx/docx_test.odt')
    expect(word_counter.words).to eq 150972
  end
  it "should count words in ppt file" do
    word_counter = described_class.from_file('spec/test_files/ppt/1.ppt')
    expect(word_counter.words).to eq 29
  end

  it "should count words in pdf file" do
    word_counter = described_class.from_file('spec/test_files/pdf/pdf_test.pdf')
    expect(word_counter.words).to eq 10138
  end

  it "should count words in rtf file" do
    word_counter = described_class.from_file('spec/test_files/rtf/rtf_test.rtf')
    expect(word_counter.words).to eq 29790
  end

  # TODO: Uncomment as soon as large TXT file parsing will be fixed
  # it "should count words in txt file" do
  #   word_counter = described_class.from_file('spec/test_files/txt/txt_test.txt')
  #   expect(word_counter.words).to eq 139860
  # end

  it "should count words in xlsx file" do
    word_counter = described_class.from_file('spec/test_files/xlsx/xlsx_test.xlsx')
    expect(word_counter.words).to eq 4
  end

  it "should count words in chineese txt file" do
    word_counter = described_class.from_file('spec/test_files/txt/txt_chineese_test.txt')
    expect(word_counter.words).to eq 3
  end

  it "should not count words in png file" do
    word_counter = described_class.from_file('spec/test_files/images/1.png')
    expect(word_counter.words).to eq 0
    expect(word_counter.errors).not_to be_empty
  end

  it "should count words without special characters" do
    text = "\tThis text has exactly eleven        \n        words.\n\n\n\n\n\n\nNon of\tspecial characters counted."
    word_counter = described_class.from_text(text)
    expect(word_counter.words).to eq 11
  end

  it "should add error if text is empty" do
    text = ""
    word_counter = described_class.from_text(text)
    expect(word_counter.words).to eq 0
    expect(word_counter.errors[:text]).to include('Text is empty')
  end
end
