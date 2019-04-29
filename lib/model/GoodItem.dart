class GoodItem{
  String title;
  String sales;
  String couponPrice;
  String yuanjia;
  String xianjia;
  String pic;
  String couponId;
  String goodId;


  GoodItem({this.title, this.sales, this.couponPrice, this.yuanjia, this.xianjia,this.pic,this.couponId,this.goodId});

  static GoodItem convertGoodItem(var itemData) {
    var xianjia = (double.parse(itemData['goods_price']) -
        double.parse(itemData['coupon_price']))
        .toStringAsFixed(2);
    return new GoodItem(
        title: itemData['goods_title'],
        sales: itemData['goods_sales'],
        couponPrice: itemData['coupon_price'],
        yuanjia: itemData['goods_price'],
        xianjia: xianjia,
        pic: itemData['goods_pic'],
        couponId: itemData['coupon_id'],
        goodId: itemData['goods_id']);
  }
}