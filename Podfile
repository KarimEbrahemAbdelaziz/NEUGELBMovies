# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'NEUGELBMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NEUGELBMovies
  pod 'Alamofire', '~> 4.8.2'
  pod 'ObjectMapper', '~> 3.4'
  pod 'Kingfisher', '~> 5.0'
  pod 'SkeletonView', '~> 1.5'
  pod 'Cosmos', '~> 19.0'
  pod 'ModernSearchBar', '~> 1.5'

  target 'NEUGELBMoviesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NEUGELBMoviesUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

plugin 'cocoapods-keys', {
  :project => "NEUGELBMovies",
  :keys => [
  "TMDBAPIKey"
  ]
}

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['ModernSearchBar'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4'
      end
    end
  end
end
