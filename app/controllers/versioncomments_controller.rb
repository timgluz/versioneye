class VersioncommentsController < ApplicationController
  
  def create
    @versioncomment = Versioncomment.new(params[:versioncomment])
    @versioncomment.user = current_user
    if @versioncomment.save      
      flash[:success] = "Comment saved!"
    else 
      flash[:error] = "Something went wrong"
    end    
    prod_key = @versioncomment.product_key
    ver = @versioncomment.version
    product = Product.find_by_key(prod_key)    
    update_product_rate(product, ver)    
    redirect_to product_version_path(product)
  end
  
  private 
  
    def update_product_rate(product, ver)
      version = product.get_version(ver)
      version.update_rate      
      version.save      
      product.update_rate
      product.save
    end
  
end