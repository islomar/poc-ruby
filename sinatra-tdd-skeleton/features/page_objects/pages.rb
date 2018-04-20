module PageObjects
    class Page
      def initialize(context)
        @context = context
      end
    end

    class HomePage < Page
        def initialize(context)
            super(context)
            @context.visit '/'
        end

        def title
            @context.page.find('h1').text
        end
    end
end