import 'artist_model.dart';
import 'merch_product_model.dart';

final List<ArtistModel> mockArtists = [
  ArtistModel(
    id: '1',
    name: 'Sơn Tùng M-TP',
    imageUrl: 'https://media.viez.vn/prod/2024/3/5/large_image_706b3e5282.png',
    productCount: 10,
    isFollowing: false,
    merchProducts: [
      MerchProduct('Ive Lightstick', 'https://media.viez.vn/prod/2024/3/1/small_1709299569439_088e2eecdb.jpeg', 80000000),
      MerchProduct('Ive Poster', 'https://media.viez.vn/prod/2024/2/19/small_1708349100374_dcedbec485.jpeg', 80000000),
    ],
  ),
  ArtistModel(
    id: '2',
    name: 'Đen Vâu',
    imageUrl: 'https://media.viez.vn/prod/2024/3/8/small_1709892339161_4bf818d00f.jpeg',
    productCount: 5,
    isFollowing: true,
    merchProducts: [
      MerchProduct('Ive Lightstick', 'https://media.viez.vn/prod/2024/3/5/small_1709608552446_46964698cf.jpeg', 80000000),
      MerchProduct('Ive Poster', 'https://media.viez.vn/prod/2023/5/15/small_1684139766153_83869151d2.jpeg', 80000000),
    ],
  ),
  ArtistModel(
    id: '3',
    name: 'Hoàng Thùy Linh',
    imageUrl: 'https://media.viez.vn/prod/2024/1/13/small_1705116657337_fdff8793aa.jpeg',
    productCount: 8,
    isFollowing: false,

    merchProducts: [
      MerchProduct('Ive Lightstick', 'https://media.viez.vn/prod/2023/9/18/small_1695006759086_a7baa768e5.jpeg', 80000000),
      MerchProduct('Ive Poster', 'https://media.viez.vn/prod/2023/9/13/small_28_EBBD_40_2567_46_CF_AA_0_B_E7138_DB_9_DBCF_6bc2538e88.png', 80000000),
    ],
  ),
  ArtistModel(
    id: '4',
    name: 'JustaTee',
    imageUrl: 'https://media.viez.vn/prod/2024/4/15/small_1713204605339_292628d0c4.jpeg',
    productCount: 6,
    isFollowing: false,
    merchProducts: [
      MerchProduct('Ive Lightstick', 'https://media.viez.vn/prod/2024/4/15/small_1713183800488_3a5bfdb908.jpeg', 80000000),
      MerchProduct('Ive Poster', 'https://media.viez.vn/prod/2024/7/24/small_1721795812759_550463e775.jpeg', 80000000),
    ],
  ),
  ArtistModel(
    id: '5',
    name: 'Binz',
    imageUrl: 'https://media.viez.vn/prod/2022/10/15/small_1665830787857_78e5a3dd4b.jpeg',
    productCount: 3,
    isFollowing: true,
    merchProducts: [
      MerchProduct('Ive Lightstick', 'https://media.viez.vn/prod/2022/3/10/small_binz_story_2c6def13a1.png', 80000000),
      MerchProduct('Ive Poster', 'https://media.viez.vn/prod/2022/6/3/small_Thiet_ke_chua_co_ten_4_f6a1fc6c03.png', 80000000),
    ],
  ),
];
