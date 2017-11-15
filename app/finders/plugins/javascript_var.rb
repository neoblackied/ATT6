module WPScan
  module Finders
    module Plugins
      # Plugins finder from the Dynamic Finder 'JavascriptVar'
      class JavascriptVar < WPScan::Finders::DynamicFinder::WpItems::Finder
        # @param [ Hash ] opts The options from the #passive, #aggressive methods
        # @param [ Typhoeus::Response ] response
        # @param [ String ] slug
        # @param [ String ] klass
        # @param [ Hash ] config The related dynamic finder config hash
        #
        # @return [ Plugin ] The detected plugin
        def process_response(opts, response, slug, klass, config)
          response.html.xpath(config['xpath'] || '//script[not(@src)]').each do |node|
            next if config['pattern'] && !node.text.match(config['pattern'])

            return Plugin.new(
              slug,
              target,
              opts.merge(found_by: found_by(klass), confidence: config['confidence'] || 60)
            )
          end
        end
      end
    end
  end
end
