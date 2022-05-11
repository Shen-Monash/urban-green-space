/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL5.7
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : plantdb

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 30/04/2022 14:29:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for allergy
-- ----------------------------
DROP TABLE IF EXISTS `allergy`;
CREATE TABLE `allergy`  (
  `allergens` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `allergen_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`allergens`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of allergy
-- ----------------------------
INSERT INTO `allergy` VALUES ('high', 'This plant will produce a lot of allergens; so be careful and mindful if choosing this in a small enclosed space.');
INSERT INTO `allergy` VALUES ('low', 'This plant produces no notable allergens.');
INSERT INTO `allergy` VALUES ('med', 'While this plant will produce some allergens; it is not expected to cause significant issues for most people.');

-- ----------------------------
-- Table structure for colour
-- ----------------------------
DROP TABLE IF EXISTS `colour`;
CREATE TABLE `colour`  (
  `colour` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`colour`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of colour
-- ----------------------------
INSERT INTO `colour` VALUES ('black');
INSERT INTO `colour` VALUES ('brown');
INSERT INTO `colour` VALUES ('dark green');
INSERT INTO `colour` VALUES ('gold');
INSERT INTO `colour` VALUES ('green');
INSERT INTO `colour` VALUES ('grey');
INSERT INTO `colour` VALUES ('lilac');
INSERT INTO `colour` VALUES ('pink');
INSERT INTO `colour` VALUES ('purple');
INSERT INTO `colour` VALUES ('red');
INSERT INTO `colour` VALUES ('white');
INSERT INTO `colour` VALUES ('yellow');

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`  (
  `location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `location_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`location`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of location
-- ----------------------------
INSERT INTO `location` VALUES ('indoors', 'This plant can survive in an indoor environment. For some plants, this means taking alittle extra care to make sure it is not too hot or too cold, find a spot for this plant that meets its requirements, some plants will like the host steamy bathroom environment, and others will prefer dryer more cool locations.');
INSERT INTO `location` VALUES ('outdoors', 'This plant can survive and thrive in outdoor environments only. This is most likely due to the size of the plant.');

-- ----------------------------
-- Table structure for maintenance
-- ----------------------------
DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance`  (
  `maint_amount` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `maint_description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`maint_amount`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of maintenance
-- ----------------------------
INSERT INTO `maintenance` VALUES ('high', 'This plant will require attention to all environmental features, such as water, sunlight, and soil, and may need to have changes occure frequently tokeep it healthy throughout the year.');
INSERT INTO `maintenance` VALUES ('low', 'The plant will most likely be albe to look after itself if left in its ideal location and environment. This plant will require very minimal attention.');
INSERT INTO `maintenance` VALUES ('med', 'This plant requires some minor attention, often to small things like water, soil, or sunlight condisiotns that may change throughout the year. For the most part, changes will occur slowly and the plant does not need to be watched attentively. ');

-- ----------------------------
-- Table structure for plant
-- ----------------------------
DROP TABLE IF EXISTS `plant`;
CREATE TABLE `plant`  (
  `plant_id` int(11) NOT NULL,
  `plant_latin_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plant_common_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_family` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_size` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_maint_amount` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_sun_reqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_water_freqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_soil_reqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plant_allergy` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`plant_id`) USING BTREE,
  UNIQUE INDEX `plant_latin_name_UNIQUE`(`plant_latin_name`) USING BTREE,
  INDEX `FK_plant_allergy_idx`(`plant_allergy`) USING BTREE,
  INDEX `FK_plant_maint_idx`(`plant_maint_amount`) USING BTREE,
  INDEX `FK_plant_soil_idx`(`plant_soil_reqs`) USING BTREE,
  INDEX `FK_plant_sun_idx`(`plant_sun_reqs`) USING BTREE,
  INDEX `FK_plant_type_idx`(`plant_type`) USING BTREE,
  INDEX `FK_plant_water_idx`(`plant_water_freqs`) USING BTREE,
  CONSTRAINT `FK_plant_allergy` FOREIGN KEY (`plant_allergy`) REFERENCES `allergy` (`allergens`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_plant_maint` FOREIGN KEY (`plant_maint_amount`) REFERENCES `maintenance` (`maint_amount`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_plant_soil` FOREIGN KEY (`plant_soil_reqs`) REFERENCES `soil` (`soil_reqs`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_plant_sun` FOREIGN KEY (`plant_sun_reqs`) REFERENCES `sun` (`sun_reqs`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_plant_type` FOREIGN KEY (`plant_type`) REFERENCES `type` (`type`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_plant_water` FOREIGN KEY (`plant_water_freqs`) REFERENCES `water` (`water_reqs`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plant
-- ----------------------------
INSERT INTO `plant` VALUES (1, 'Callistemon pityoides', 'Alpine Bottlebrush', 'Myrtaceae', 'Callistemon pityoides grows naturally to 3 m high and 2 m wide at altitudes from above 2000 m down to around 900 m. It is found commonly in and around sphagnum bogs and swamps and along watercourses in Queensland, New South Wales and Victoria, mainly on the coast and tablelands, often on granite or peat.', 'other', 'large', 'high', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (2, 'Cymbidium suave', 'Snake Orchid or Grassy Boat-lip Orchid', 'Orchidaceae', 'Cymbidium suave is a leafy clumping orchid which sometimes resembles a Lomandra. It is usually seen growing in eucalypt trees as an epiphyte. It is about 0.5 m tall by 0.5 m or more wide and has attractive yellow scented flowers in spring and summer.', 'other', 'small', 'high', 'shady', 'high', 'high', 'high');
INSERT INTO `plant` VALUES (3, 'Abutilon otocarpum', 'Desert Chinese Lantern', 'Malvaceae', 'Abutilon otocarpum is a small shrub to about 0.7 metres tall, found on the western plains on NSW, in semi-arid conditions; on red sandy soils, sand rises and dunes. It is also found in all other mainland states in similar habitats.', 'shrubs-small', 'small', 'low', 'full', 'low', 'low', 'med');
INSERT INTO `plant` VALUES (4, 'Abutilon oxycarpum', 'Flannel weed, Straggly Lantern-bush, Small-leaved Abutilon, Swamp Chinese-lantern, Chingma lantern', 'Malvaceae', 'Abutilon oxycarpum is a soft-woody shrub growing up to 2 m tall, found naturally on rocky hill slopes as well as creek banks in dry sclerophyll woodlands and forests and sometimes in rainforest, in all states of Australia with the exception of Tasmania. In NSW, it grows on the coastal, tablelands and western slopes, with most of its distribution north of Sydney (but also extending down the south.', 'shrubs-large', 'large', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (5, 'Doryanthes excelsa', 'Giant Lily, Flame Lily, Spear Lily, Illawarra Lily, Gymea Lily', 'Doryanthaceae', 'Doryanthes excelsa, the Gymea Lily, is a hardy, clumping monocot with fibrous sword-like leaves which grow up to 1.5 m long and 10 to 12 cm wide. It grows from a thickened underground stem which penetrates deep into the ground to protect against drought and fire, so does best in deep soil.', 'grasses-and-clumping', 'large', 'low', 'full', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (6, 'Grevillea diversifolia', 'None', 'Proteaceae', 'Grevillea diversifolia is a native of the south-west corner of Western Australia. The species is said to reach a height of five metres. Our specimens, after ten years, are about 1.5 metres tall by the same width. Our specimens, after ten years, are about 1.5 metres tall by the same width. The leaves are up to 40 millimetres long and broad near the apex. A few leaves are lobed. This feature has probably given rise to the species name.', 'shrubs-large', 'large', 'low', 'mixed', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (7, 'Actinotus gibbonsii', 'Dwarf Flannel Flower, Gibbons Flannel Flower', 'Apiaceae', 'Actinotus gibbonsii is an annual or perennial herb with ascending or decumbent stems to 30 cm long growing in eucalypt woodland and shrubby heath in sandy (often red) soils. It has a natural distribution in NSW, generally from the coastal/tablelands boundaries to the western plains, extending into QLD and just into Victoria.', 'ground-covers', 'medium', 'low', 'mixed', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (8, 'Actinotus helianthi', 'Flannel flower', 'Apiaceae', 'Actinotus helianthi is Aasoft-wooded shrub, growing to one meter in good conditions. It grows mainly in coastal NSW, in open forest and woodland as well as heaths. It also grows inland on the western slopes and tablelands extending into southern Queensland, as far north as Carnarvon Gorge and Isla Gorge, in sclerophyll woodland and shrublands.', 'shrubs-small', 'small', 'low', 'mixed', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (9, 'Asplenium attenuatum', 'Simple Spleenwort', 'Aspleniaceae', 'Asplenium attenuatum ‚Äì A clumping fern found in gullies and shady areas on creeklines in dry and wet sclerophyll forest and rainforest. It grows on rocks or on tree trunks. It grows along the coast of NSW, north from the lower Blue Mountains, into Qld.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (10, 'Asplenium flabellifolium', 'Necklace Fern', 'Aspleniaceae', 'Asplenium flabellifolium ‚Äì A delicate ground-trailing fern (prostrate) found in gullies of open forest and rainforest, in rock crevices and sometime growing as an epiphyte on logs and rocks.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (11, 'Asplenium flaccidum', 'Weeping Spleenwort', 'Aspleniaceae', 'Asplenium flaccidum ‚Äì A very attractive fern, often found hanging in pendent clumps, growing on trees and rocks in rainforest.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (12, 'Asplenium polyodon', 'Sickle Spleenwort / Mare‚Äôs Tail Fern', 'Aspleniaceae', 'Asplenium polyodon ‚Äì A pendent fern which a thick rhizome, often found growing epiphytically on trees or on rocks.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (13, 'Asplenium pteridoides', 'Hen and Chicken Fern', 'Aspleniaceae', 'Asplenium pteridoides ‚Äì A very attractive clumping fern confined to Lord Howe Island. It is typically found in mountainous rainforest, growing on basalt in cool rain forest understorey.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (14, 'Asplenium trichomanes', 'Common Spleenwort', 'Aspleniaceae', 'Asplenium trichomanes ‚Äì A delicate erect ground fern, growing from a rhizome, found in higher altitudes on the tablelands of NSW, usually on limestone substrates.', 'ferns', 'medium', 'low', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (15, 'Adiantum hispidulum', 'Rough Maidenhair Fern, Five-fingered Jack, Five-finger Maidenhair', 'Pteridaceae', 'Adiantum hispidulum ‚Äì A widespread perennial fern, found naturally in both rainforest and open, exposed areas in Queensland, New South Wales, Victoria and the Northern Territory. Also occurs outside of Australia. In NSW, it grows along the extent of the coast and into the central and northern tablelands and western slopes. It does not grow in the general western half of the country.', 'ferns', 'medium', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (16, 'Adiantum silvaticum', 'Rough Maidenhair, Forest Maidenhair Fern', 'Pteridaceae', 'Adiantum silvaticum ‚Äì A comparatively taller maidenhair fern growing in rainforest or open eucalyptus forests, often along streams and moist cliff faces; north from the Illawarra region along the coast in NSW, extending west into the and ranges and into Queensland.', 'ferns', 'medium', 'low', 'shady', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (17, 'Acacia acinacea', 'Gold Dust Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia acinacea is a small to medium shrub that is found in south-eastern South Australia, most of Victoria and southern NSW. Phyllodes are small, elliptic with an offset mucro (pointed end). There is a small gland near the centre of the phyllode margin. The flowers are in globular heads with 8-20 flowers in each head. Blooms are bright golden and carried in pairs at the base of each phyllode.', 'shrubs-small', 'small', 'med', 'mixed', 'med', 'low', 'med');
INSERT INTO `plant` VALUES (18, 'Acacia amblygona', 'Acacia amblygona', 'Fabaceae subfamily Mimosoideae', 'Acacia amblygona is a small shrub reaching a maximum height of 1.5 metres.¬†All forms have dark green, rigid, almost triangular, prickly phyllodes and there is a prostrate form registered as ‚ÄòAustraflora Winter Gold‚Äô.', 'shrubs-large', 'large', 'med', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (19, 'Acacia amoena', 'Boomerang Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia amoena is known as the Boomerang Wattle this name probably refers to the shape of the phyllode but this name could apply to any number of species with similar phyllodes. Acacia amoena is an erect shrub that reaches a height of two metres in our cold climate garden.', 'shrubs-large', 'large', 'med', 'mixed', 'low', 'low', 'med');
INSERT INTO `plant` VALUES (20, 'Acacia aphylla', 'Leafless Rock Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia aphylla is a wiry, narrow spiky shrub, to 3 m high, it is endemic to Western Australia and it listed as threatened with extinction.', 'shrubs-large', 'large', 'med', 'full', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (21, 'Adiantum aethiopicum', 'Common Maidenhair Fern', 'Pteridaceae', 'Adiantum aethiopicum ‚Äì A common plant in Australia, growing along the extent of the NSW coast, tablelands and western slopes, as well as other mainland states except for Northern Territory. It also occurs in Africa, Norfolk Island and New Zealand.', 'ferns', 'large', 'med', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (22, 'Asplenium australasicum', 'Birds Nest Fern', 'Aspleniaceae', 'Asplenium australasicum ‚Äì A common and widespread clumping epiphytic fern typically found growing in trees and on rocks (lithophytic) in rainforest and wet sclerophyll forests.', 'ferns', 'large', 'med', 'shady', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (23, 'Asplenium gracillimum', 'Hen and Chicken Fern', 'Aspleniaceae', 'Asplenium gracillimum ‚Äì A very attractive clumping fern confined mainly to the mountainous areas on the NSW coast and tablelands junctions. It also grows in Qld, Vic, S.A and Tasmania. Plants in NZ are named Asplenium bulbiferum.', 'ferns', 'med-large', 'med', 'shady', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (24, 'Cissus antarctica', 'Kangaroo Vine; Water Vine; Vine, Water; Vine', 'Vitaceae', 'Cissus antarctica ‚Äì A vigorous vine, endemic to Australia, occurs in north-east Queensland and central-east Queensland and southwards as far as south-eastern New South Wales. In NSW, it grows along the coast mainly but extends into the tablelands and central western slopes.', 'vines-and-scramblers', 'medium', 'med', 'mixed', 'med', 'low', 'med');
INSERT INTO `plant` VALUES (25, 'Eremophila decipiens', '\'Slender Emu Bush\'', 'Scrophulariaceae', 'Eremophila decipiens, Slender Emu Bush, is a small shrub that reaches a height of one metre.¬†Flowers are typically tubular with four upper lobes and one lower. Blooms are bright red, profuse and appear from April to November.', 'shrubs-small', 'small', 'med', 'direct', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (26, 'Grevillea floribunda', 'Rusty Spider Flower', 'Proteaceae', 'Grevillea floribunda, Rusty Spider Flower, is a dwarf to medium shrub with oval to long shaped leaves. Young growth is rusty-hairy. Adult leaves are deep green above and greyish hairy beneath.¬†The unusual flowers are rusty-green, tightly clustered in groups of seven or so.', 'shrubs-large', 'large', 'med', 'mixed', 'low', 'low', 'med');
INSERT INTO `plant` VALUES (27, 'Actinotus forsythii', 'Pink flannel flower, Ridge Flannel-flower', 'Apiaceae', 'Actinotus forsythii is a herbaceous wiry perennial, mostly prostrate with stems to 50 cm long. It is typically found in the Blue Mountains, south of Katoomba, extending south to the south coast and southern tablelands.', 'ground-covers', 'medium', 'med', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (28, 'Adiantum diaphanum', 'Filmy maidenhair fern', 'Pteridaceae', 'Adiantum diaphanum ‚Äì A rhizomatous perennial fern, growing in rainforest, often along streams or near waterfalls, mainly found on the NSW Coast and slightly into the ranges, extending in Queensland and down into Victoria. Also grows in NZ.', 'ferns', 'medium', 'med', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (29, 'Adiantum formosum', 'Giant Maidenhair Fern, Black Stem Maidenhair', 'Pteridaceae', 'Adiantum formosum ‚Äì A perennial ground fern growing to about 120 cm. Widespread, growing in colonies in rainforest or open forest, on alluvial flats near streams, along the coast to the ranges from QLD, down into Victoria. It can dominate the groundlayer in some cases (eg: along the southern end of Lady Carrington Drive in the Royal National Park).', 'ferns', 'large', 'med', 'shady', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (30, 'Azolla filiculoides', 'Water Fern', 'Azollaceae', 'Azolla filiculoides,¬†Water Fern, is a member of the Azollaceae family and is a small, aquatic, free-floating fern. The fronds range in colour from green to deep red in colour. It¬†is common in dams and other still bodies of water where it forms dense carpets.', 'ferns', 'small', 'med', 'mixed', 'waterplant', 'low', 'low');
INSERT INTO `plant` VALUES (31, 'Cyathea australis', 'Rough Tree Fern', 'Cyatheaceae', 'Cyathea australis is an arboreal tree-fern growing to potentially 20 m tall. It is known as the Rough Tree Fern due to the presence of shield-like plates (bases of old fronds), tubercles (knobbly bits) and masses of hair-like scales on its ‚Äòtrunk‚Äô.', 'ferns', 'large', 'med', 'shady', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (32, 'Cyathea cooperi', 'Lacy tree fern, Australian tree fern', 'Cyatheaceae', 'Cyathea cooperi is a great, beautiful looking ornamental background or feature plant which grows best in high humidity and high soil moisture conditions. Use good quality mulches and top them up regularly as this will keep the soil moist and also provide nutrients to the shallow root system. Grow in a shady position with some protection from hot western sun for it to look its best. Responds well to small amounts of organic fertiliser.', 'ferns', 'medium', 'med', 'shady', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (33, 'Calostemma purpureum', 'Garland Lily', 'Amaryllidaceae', 'Calostemma purpureum seems to be one of those plants that gain popularity and then, for some unknown reason just stop being around, at least in the local area of Newcastle. When first starting a native garden, I recall seeing this attractive plant in other members‚Äô gardens and also available to buy in specialist nurseries. I am pleased that I have ‚Äúrediscovered‚Äù this lily and had the pleasure of many flowering heads during late summer. Commonly called Garland Lily, it belongs to the family', 'grasses-and-clumping', 'medium', 'med', 'full', 'med', 'low', 'high');
INSERT INTO `plant` VALUES (34, 'Calotis cuneifolia', 'Burr Daisy', 'Asteraceae', 'Calotis cuneifolia is a member of the Asteraceae (Daisy) family. The genus is usually known as Burr Daisies.¬†It is a dwarf, rounded perennial, with white or lilac daisy flower heads and small wedge-shaped leaves (cuneate, hence the species name).', 'ground-covers', 'medium', 'med', 'mixed', 'med', 'low', 'med');

-- ----------------------------
-- Table structure for plant_colour
-- ----------------------------
DROP TABLE IF EXISTS `plant_colour`;
CREATE TABLE `plant_colour`  (
  `plant_id` int(11) NOT NULL,
  `colour` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`plant_id`, `colour`) USING BTREE,
  INDEX `FK_plant_colour_bridge_idx`(`colour`) USING BTREE,
  CONSTRAINT `FK_colour_plant_bridge` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`plant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_plant_colour_bridge` FOREIGN KEY (`colour`) REFERENCES `colour` (`colour`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plant_colour
-- ----------------------------
INSERT INTO `plant_colour` VALUES (16, 'black');
INSERT INTO `plant_colour` VALUES (34, 'brown');
INSERT INTO `plant_colour` VALUES (18, 'dark green');
INSERT INTO `plant_colour` VALUES (17, 'gold');
INSERT INTO `plant_colour` VALUES (18, 'gold');
INSERT INTO `plant_colour` VALUES (19, 'gold');
INSERT INTO `plant_colour` VALUES (1, 'green');
INSERT INTO `plant_colour` VALUES (2, 'green');
INSERT INTO `plant_colour` VALUES (5, 'green');
INSERT INTO `plant_colour` VALUES (6, 'green');
INSERT INTO `plant_colour` VALUES (7, 'green');
INSERT INTO `plant_colour` VALUES (9, 'green');
INSERT INTO `plant_colour` VALUES (10, 'green');
INSERT INTO `plant_colour` VALUES (11, 'green');
INSERT INTO `plant_colour` VALUES (12, 'green');
INSERT INTO `plant_colour` VALUES (13, 'green');
INSERT INTO `plant_colour` VALUES (14, 'green');
INSERT INTO `plant_colour` VALUES (15, 'green');
INSERT INTO `plant_colour` VALUES (16, 'green');
INSERT INTO `plant_colour` VALUES (18, 'green');
INSERT INTO `plant_colour` VALUES (21, 'green');
INSERT INTO `plant_colour` VALUES (22, 'green');
INSERT INTO `plant_colour` VALUES (23, 'green');
INSERT INTO `plant_colour` VALUES (24, 'green');
INSERT INTO `plant_colour` VALUES (25, 'green');
INSERT INTO `plant_colour` VALUES (26, 'green');
INSERT INTO `plant_colour` VALUES (28, 'green');
INSERT INTO `plant_colour` VALUES (29, 'green');
INSERT INTO `plant_colour` VALUES (30, 'green');
INSERT INTO `plant_colour` VALUES (31, 'green');
INSERT INTO `plant_colour` VALUES (32, 'green');
INSERT INTO `plant_colour` VALUES (33, 'green');
INSERT INTO `plant_colour` VALUES (34, 'green');
INSERT INTO `plant_colour` VALUES (26, 'grey');
INSERT INTO `plant_colour` VALUES (34, 'lilac');
INSERT INTO `plant_colour` VALUES (7, 'pink');
INSERT INTO `plant_colour` VALUES (15, 'pink');
INSERT INTO `plant_colour` VALUES (16, 'pink');
INSERT INTO `plant_colour` VALUES (25, 'pink');
INSERT INTO `plant_colour` VALUES (27, 'pink');
INSERT INTO `plant_colour` VALUES (16, 'purple');
INSERT INTO `plant_colour` VALUES (33, 'purple');
INSERT INTO `plant_colour` VALUES (5, 'red');
INSERT INTO `plant_colour` VALUES (6, 'red');
INSERT INTO `plant_colour` VALUES (7, 'red');
INSERT INTO `plant_colour` VALUES (15, 'red');
INSERT INTO `plant_colour` VALUES (22, 'red');
INSERT INTO `plant_colour` VALUES (23, 'red');
INSERT INTO `plant_colour` VALUES (25, 'red');
INSERT INTO `plant_colour` VALUES (30, 'red');
INSERT INTO `plant_colour` VALUES (33, 'red');
INSERT INTO `plant_colour` VALUES (34, 'red');
INSERT INTO `plant_colour` VALUES (6, 'white');
INSERT INTO `plant_colour` VALUES (8, 'white');
INSERT INTO `plant_colour` VALUES (24, 'white');
INSERT INTO `plant_colour` VALUES (25, 'white');
INSERT INTO `plant_colour` VALUES (27, 'white');
INSERT INTO `plant_colour` VALUES (34, 'white');
INSERT INTO `plant_colour` VALUES (1, 'yellow');
INSERT INTO `plant_colour` VALUES (2, 'yellow');
INSERT INTO `plant_colour` VALUES (3, 'yellow');
INSERT INTO `plant_colour` VALUES (4, 'yellow');
INSERT INTO `plant_colour` VALUES (5, 'yellow');
INSERT INTO `plant_colour` VALUES (8, 'yellow');
INSERT INTO `plant_colour` VALUES (18, 'yellow');
INSERT INTO `plant_colour` VALUES (19, 'yellow');
INSERT INTO `plant_colour` VALUES (20, 'yellow');
INSERT INTO `plant_colour` VALUES (26, 'yellow');

-- ----------------------------
-- Table structure for plant_location
-- ----------------------------
DROP TABLE IF EXISTS `plant_location`;
CREATE TABLE `plant_location`  (
  `plant_id` int(11) NOT NULL,
  `location` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`plant_id`, `location`) USING BTREE,
  INDEX `FK_plant_location_bridge_idx`(`location`) USING BTREE,
  CONSTRAINT `FK_location_plant_bridge` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`plant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_plant_location_bridge` FOREIGN KEY (`location`) REFERENCES `location` (`location`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plant_location
-- ----------------------------
INSERT INTO `plant_location` VALUES (2, 'indoors');
INSERT INTO `plant_location` VALUES (7, 'indoors');
INSERT INTO `plant_location` VALUES (8, 'indoors');
INSERT INTO `plant_location` VALUES (9, 'indoors');
INSERT INTO `plant_location` VALUES (10, 'indoors');
INSERT INTO `plant_location` VALUES (11, 'indoors');
INSERT INTO `plant_location` VALUES (12, 'indoors');
INSERT INTO `plant_location` VALUES (13, 'indoors');
INSERT INTO `plant_location` VALUES (14, 'indoors');
INSERT INTO `plant_location` VALUES (15, 'indoors');
INSERT INTO `plant_location` VALUES (16, 'indoors');
INSERT INTO `plant_location` VALUES (17, 'indoors');
INSERT INTO `plant_location` VALUES (21, 'indoors');
INSERT INTO `plant_location` VALUES (22, 'indoors');
INSERT INTO `plant_location` VALUES (23, 'indoors');
INSERT INTO `plant_location` VALUES (24, 'indoors');
INSERT INTO `plant_location` VALUES (28, 'indoors');
INSERT INTO `plant_location` VALUES (29, 'indoors');
INSERT INTO `plant_location` VALUES (30, 'indoors');
INSERT INTO `plant_location` VALUES (32, 'indoors');
INSERT INTO `plant_location` VALUES (1, 'outdoors');
INSERT INTO `plant_location` VALUES (2, 'outdoors');
INSERT INTO `plant_location` VALUES (3, 'outdoors');
INSERT INTO `plant_location` VALUES (4, 'outdoors');
INSERT INTO `plant_location` VALUES (5, 'outdoors');
INSERT INTO `plant_location` VALUES (6, 'outdoors');
INSERT INTO `plant_location` VALUES (7, 'outdoors');
INSERT INTO `plant_location` VALUES (8, 'outdoors');
INSERT INTO `plant_location` VALUES (9, 'outdoors');
INSERT INTO `plant_location` VALUES (10, 'outdoors');
INSERT INTO `plant_location` VALUES (11, 'outdoors');
INSERT INTO `plant_location` VALUES (12, 'outdoors');
INSERT INTO `plant_location` VALUES (13, 'outdoors');
INSERT INTO `plant_location` VALUES (14, 'outdoors');
INSERT INTO `plant_location` VALUES (15, 'outdoors');
INSERT INTO `plant_location` VALUES (16, 'outdoors');
INSERT INTO `plant_location` VALUES (17, 'outdoors');
INSERT INTO `plant_location` VALUES (18, 'outdoors');
INSERT INTO `plant_location` VALUES (19, 'outdoors');
INSERT INTO `plant_location` VALUES (20, 'outdoors');
INSERT INTO `plant_location` VALUES (21, 'outdoors');
INSERT INTO `plant_location` VALUES (22, 'outdoors');
INSERT INTO `plant_location` VALUES (23, 'outdoors');
INSERT INTO `plant_location` VALUES (24, 'outdoors');
INSERT INTO `plant_location` VALUES (25, 'outdoors');
INSERT INTO `plant_location` VALUES (26, 'outdoors');
INSERT INTO `plant_location` VALUES (27, 'outdoors');
INSERT INTO `plant_location` VALUES (28, 'outdoors');
INSERT INTO `plant_location` VALUES (29, 'outdoors');
INSERT INTO `plant_location` VALUES (30, 'outdoors');
INSERT INTO `plant_location` VALUES (31, 'outdoors');
INSERT INTO `plant_location` VALUES (32, 'outdoors');
INSERT INTO `plant_location` VALUES (33, 'outdoors');
INSERT INTO `plant_location` VALUES (34, 'outdoors');

-- ----------------------------
-- Table structure for plant_produce
-- ----------------------------
DROP TABLE IF EXISTS `plant_produce`;
CREATE TABLE `plant_produce`  (
  `plant_id` int(11) NOT NULL,
  `produce` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`plant_id`, `produce`) USING BTREE,
  INDEX `FK_plant_produce_bridge_idx`(`produce`) USING BTREE,
  CONSTRAINT `FK_plant_produce_bridge` FOREIGN KEY (`produce`) REFERENCES `produce` (`produce`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_produce_plant_bridge` FOREIGN KEY (`plant_id`) REFERENCES `plant` (`plant_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of plant_produce
-- ----------------------------
INSERT INTO `plant_produce` VALUES (1, 'flowers');
INSERT INTO `plant_produce` VALUES (2, 'flowers');
INSERT INTO `plant_produce` VALUES (3, 'flowers');
INSERT INTO `plant_produce` VALUES (4, 'flowers');
INSERT INTO `plant_produce` VALUES (5, 'flowers');
INSERT INTO `plant_produce` VALUES (6, 'flowers');
INSERT INTO `plant_produce` VALUES (7, 'flowers');
INSERT INTO `plant_produce` VALUES (17, 'flowers');
INSERT INTO `plant_produce` VALUES (18, 'flowers');
INSERT INTO `plant_produce` VALUES (19, 'flowers');
INSERT INTO `plant_produce` VALUES (20, 'flowers');
INSERT INTO `plant_produce` VALUES (24, 'flowers');
INSERT INTO `plant_produce` VALUES (25, 'flowers');
INSERT INTO `plant_produce` VALUES (26, 'flowers');
INSERT INTO `plant_produce` VALUES (27, 'flowers');
INSERT INTO `plant_produce` VALUES (33, 'flowers');
INSERT INTO `plant_produce` VALUES (34, 'flowers');
INSERT INTO `plant_produce` VALUES (3, 'fruits');
INSERT INTO `plant_produce` VALUES (7, 'fruits');
INSERT INTO `plant_produce` VALUES (24, 'fruits');
INSERT INTO `plant_produce` VALUES (33, 'fruits');
INSERT INTO `plant_produce` VALUES (34, 'fruits');

-- ----------------------------
-- Table structure for produce
-- ----------------------------
DROP TABLE IF EXISTS `produce`;
CREATE TABLE `produce`  (
  `produce` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `produce_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`produce`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of produce
-- ----------------------------
INSERT INTO `produce` VALUES ('flowers', 'This plant will produce season flowers, which will attract things like birds and bees to your garden or balcony');
INSERT INTO `produce` VALUES ('fruits', 'This plant will produce fruits, which animals such as possums and bats will want to get into as well as birds and bees. ');

-- ----------------------------
-- Table structure for soil
-- ----------------------------
DROP TABLE IF EXISTS `soil`;
CREATE TABLE `soil`  (
  `soil_reqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `soil_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`soil_reqs`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of soil
-- ----------------------------
INSERT INTO `soil` VALUES ('high', 'This plant wil need specific soil for it to thrive. Some plants, like orchids, need specific extra fertile soil to grow well and produce flowers. ');
INSERT INTO `soil` VALUES ('low', 'The soil used for this plant can be generic, and a fertiliser is most likely not required.');
INSERT INTO `soil` VALUES ('med', 'The soil quality for this plant needs to be considered, and maybe a fertiliser will be ebst to help this plant grow well. ');

-- ----------------------------
-- Table structure for sun
-- ----------------------------
DROP TABLE IF EXISTS `sun`;
CREATE TABLE `sun`  (
  `sun_reqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sun_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sun_reqs`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sun
-- ----------------------------
INSERT INTO `sun` VALUES ('direct', 'This plant likes the direct sun, and can handle the ahrsher sunshine in the afternnons. While it can survive shaded, it really wants to see the sun.');
INSERT INTO `sun` VALUES ('full', 'This plant likes full sun, which means that it wants to have a consistent amount of sunshine. This differs from direct sunlight, as this plant wants sun allthe time, not just direct sun, meaning commonly overcast places may not be best.');
INSERT INTO `sun` VALUES ('mixed', 'This plant likes to have a mix of sunny and shades periods. This is most likely morning sunshisne, which is less harsh, and shade in the afternoon when the sun becomes hotter and more likely to burn the plant. ');
INSERT INTO `sun` VALUES ('shady', 'This plants wants naturaly light, but not direct sunlight. Somewhree shaded outdoors, or somewhere near a window indoors. ');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES ('ferns', 'Ferns are vascular plants which reproduce by spores, not having either seeds or flowers. They are characterised by having fronds which unfurl as they grow. ');
INSERT INTO `type` VALUES ('grasses-and-clumping', 'are generally herbaceous with the distinctive flowing shape of grasses\"are generally herbaceous with the distinctive flowing shape of grasses\"');
INSERT INTO `type` VALUES ('ground-covers', 'Ground covers are generally under 1 metre and can be prostrate, dwarf or herbaceous plants. They provide the lower level of the garden, and fill in between the shrubs and trees');
INSERT INTO `type` VALUES ('other', 'There are many more plant types in the Australian landscape that are captured in this section. This includes wetland plants – those which cope with damp soil with the roots in the water or on the edges of water. They are excellent for:');
INSERT INTO `type` VALUES ('shrubs-large', 'Shrubs abound in Australia, ranging from low ground hugging ones to those up to 6 metres tall. All have multiple woody stems.');
INSERT INTO `type` VALUES ('shrubs-small', 'There are many shrubs in Australia’s flora, which is fortunate as they provide the bulk of the mid layer of the garden. They have multiple woody stems. ');
INSERT INTO `type` VALUES ('vines-and-scramblers', 'Vines and scramblers are adapted to either growing up or out across the ground using modified stems and leaves such as tendrils, twining stems, thorns and hooks. Climbers can be used as a ground cover or to decorate garden structures.');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_code` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_password` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plants` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', 'e10adc3949ba59abbe56e057f20f883e', '0');
INSERT INTO `user` VALUES (2, '李四', 'f379eaf3c831b04de153469d1bec345e', '0');

-- ----------------------------
-- Table structure for water
-- ----------------------------
DROP TABLE IF EXISTS `water`;
CREATE TABLE `water`  (
  `water_reqs` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `water_desc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `water_freq` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`water_reqs`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of water
-- ----------------------------
INSERT INTO `water` VALUES ('high', 'The water content in the plant should be kept high, and the amount of water added should not floood the plant', 'daily');
INSERT INTO `water` VALUES ('low', 'The plant can survive with miniaml water, and should never be too wet, but make sure the soil does not dry out. ', 'weekly');
INSERT INTO `water` VALUES ('med', 'This plants needs to monitored to make sure that it is not over watered, but also to make sure that the soil is not drying out too much', 'every few days');
INSERT INTO `water` VALUES ('waterplant', 'This plant wants to live in water, therefore, the water requirements are a bit different. A consistent, but clean, body of water should be sufficient for this plant to survive. The water frequency for this pla nt is how often to ensure the watre is clean', 'bi-weekly');

SET FOREIGN_KEY_CHECKS = 1;
