class ExportPdf
  include Prawn::View

  def initialize(remitos, consumers)
    @remitos = remitos
    @consumers = consumers
    header
    font_setup # this is a new line
    content
    table_content
  end

  # This is the new method with font declaration
  def font_setup
    font_families.update("NotoSans" => {
      :normal => "#{Rails.root}/app/assets/fonts/noto/NotoSans-Regular.ttf",
      :italic => "#{Rails.root}/app/assets/fonts/noto/NotoSans-Italic.ttf",
      :bold => "#{Rails.root}/app/assets/fonts/noto/NotoSans-Bold.ttf",
    })
    font "NotoSans"
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/v2/logoMai.png"
  end

  def content
    y_position = cursor - 50

    bounding_box([0, y_position], :width => 270, :height => 300) do
      text "Lorem ipsum", size: 15, style: :bold
      text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat.
      Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante,
      eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum,
      ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum.
      Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet.
      Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo.
      Ut sodales libero erat, at gravida enim rhoncus ut."
    end

    bounding_box([300, y_position], :width => 270, :height => 300) do
      text "Duis vel", size: 15, style: :bold
      text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis
      eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante
      ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed
      tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis
      neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per
      conubia nostra, per inceptos himenaeos."
    end
    text "Hello World!"
  end

  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [40, 300, 200]
    end
  end

  def product_rows
    [['#', 'Name', 'Price']] +
      @remitos.map do |product_id, products|
        [product_id, 'n', 'product.price']
      end
  end


end