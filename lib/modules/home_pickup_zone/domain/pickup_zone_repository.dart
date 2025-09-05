import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'pickup_zone_model.dart';

class PickupZoneRepository {
  Future<List<PickupZoneModel>> getPickupZones() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      PickupZoneModel(
        id: 'zone_1',
        name: 'Quận 1',
        description: 'Trung tâm thành phố',
        center: LatLng(10.7769, 106.7009),
        boundaries: [
          LatLng(10.793653354265018, 106.70072500055164),
          LatLng(10.797888474031964, 106.70466451566654),
          LatLng(10.799725491614055, 106.70658338878127),
          LatLng(10.800659098525003, 106.7082087831273),
          LatLng(10.801177221671878, 106.70961924505309),
          LatLng(10.801447831360846, 106.71136861015589),
          LatLng(10.80128546557674, 106.71371027998026),
          LatLng(10.800433043768265, 106.71635498942743),
          LatLng(10.797860504820918, 106.72116976574443),
          LatLng(10.796451367598664, 106.71957979118321),
          LatLng(10.795801893130673, 106.7186431232534),
          LatLng(10.795179478782472, 106.71829876004529),
          LatLng(10.792765285576635, 106.71822994526843),
          LatLng(10.790938612655367, 106.7181335235694),
          LatLng(10.789977913554182, 106.71766518960453),
          LatLng(10.789233707914605, 106.71635660940882),
          LatLng(10.789064274352768, 106.71515537992883),
          LatLng(10.789646108337138, 106.71153267896642),
          LatLng(10.789104867457368, 106.71030674594192),
          LatLng(10.786426349508716, 106.70893334760262),
          LatLng(10.785043172796918, 106.70837426831957),
          LatLng(10.782398846673956, 106.70613795118567),
          LatLng(10.790413117376957, 106.69746186897544),
          LatLng(10.79365321616848, 106.70072506064594),
        ],
        operatingHours: '8:00 - 22:00',
        supportedServices: ['Thu mua điện thoại', 'Thu mua laptop'],
      ),
      PickupZoneModel(
        id: 'zone_3',
        name: 'Quận 3',
        description: 'Khu vực mở rộng',
        center: LatLng(10.7860, 106.6917),
        boundaries: [
          LatLng(10.820370291742535, 106.69420347918424),
          LatLng(10.822758170826788, 106.70338600641782),
          LatLng(10.820046134221727, 106.70398753339464),
          LatLng(10.818975131814895, 106.70449331442677),
          LatLng(10.810219873056852, 106.71230614685197),
          LatLng(10.808134599095155, 106.71167944186294),
          LatLng(10.807220490223557, 106.71156470838042),
          LatLng(10.805635168197838, 106.71152982558306),
          LatLng(10.801444235597955, 106.71134382298658),
        ],
        operatingHours: '9:00 - 21:00',
        supportedServices: ['Thu mua điện thoại'],
      ),
      PickupZoneModel(
        id: 'zone_binh_thanh',
        name: 'Bình Thạnh',
        description: 'Khu vực Bình Thạnh',
        center: LatLng(10.8039, 106.7076),
        boundaries: [
          LatLng(10.81218504402578, 106.72050033288139),
          LatLng(10.81213306384435, 106.71942316761546),
          LatLng(10.811977623951357, 106.71835637715034),
          LatLng(10.811720221477076, 106.71731023632906),
          LatLng(10.811363335606453, 106.71629482104356),
          LatLng(10.810910403693258, 106.71531991116045),
          LatLng(10.810365788143113, 106.71439489630237),
          LatLng(10.809734734384822, 106.71352868539364),
          LatLng(10.809023320335458, 106.7127296208422),
          LatLng(10.808238397846507, 106.71200539818527),
          LatLng(10.807387526695832, 106.71136299197299),
          LatLng(10.806478901761915, 106.71080858860394),
          LatLng(10.80552127408254, 106.71034752675915),
          LatLng(10.80452386655897, 106.70998424600812),
          LatLng(10.803496285118092, 106.70972224408044),
          LatLng(10.802448426188755, 106.70956404321402),
          LatLng(10.80139038138388, 106.70951116590236),
          LatLng(10.800332340306602, 106.70956412027316),
          LatLng(10.79928449241681, 106.70972239523738),
          LatLng(10.798256928903172, 106.70998446545397),
          LatLng(10.797259545505616, 106.71034780606077),
          LatLng(10.796301947223872, 106.7108089170279),
          LatLng(10.79539335582947, 106.71136335689816),
          LatLng(10.794542521071289, 106.71200578558775),
          LatLng(10.79375763642927, 106.71273001583434),
          LatLng(10.793046260226838, 106.7135290727961),
          LatLng(10.792415242861042, 106.71439526122752),
          LatLng(10.79187066085041, 106.71532023958441),
          LatLng(10.791417758334847, 106.71629510034516),
          LatLng(10.791060896590238, 106.71731045577492),
          LatLng(10.790803512043201, 106.71835652830728),
          LatLng(10.790648083189751, 106.71942324467462),
          LatLng(10.79059610673592, 106.72050033288139),
        ],
        operatingHours: '8:00 - 21:00',
        supportedServices: ['Thu mua điện thoại', 'Thu mua laptop'],
      ),
    ];
  }

  Future<List<LocationModel>> getLocations() async {
    await Future.delayed(Duration(milliseconds: 300));
    return [
      LocationModel(
        id: 'loc_1',
        name: 'Địa điểm',
        district: 'Tất cả',
        coordinates: LatLng(10.7769, 106.7009),
        hasPickupService: true,
      ),
      LocationModel(
        id: 'loc_2',
        name: 'Quận 1',
        district: 'Quận 1',
        coordinates: LatLng(10.7769, 106.7009),
        hasPickupService: true,
      ),
      LocationModel(
        id: 'loc_3',
        name: 'Quận 3',
        district: 'Quận 3',
        coordinates: LatLng(10.7860, 106.6917),
        hasPickupService: true,
      ),
      LocationModel(
        id: 'loc_5',
        name: 'Quận 5',
        district: 'Quận 5',
        coordinates: LatLng(10.7594, 106.6672),
        hasPickupService: false,
      ),
      LocationModel(
        id: 'loc_6',
        name: 'Bình Thạnh',
        district: 'Bình Thạnh',
        coordinates: LatLng(10.8039, 106.7076),
        hasPickupService: true,
      ),
    ];
  }

  Future<bool> submitBookingRequest(BookingRequestModel request) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}


