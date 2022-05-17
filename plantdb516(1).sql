/*
 Navicat Premium Data Transfer

 Source Server         : qwe
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : plantdb

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 17/05/2022 01:13:27
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
  `plant_desc` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
INSERT INTO `plant` VALUES (35, 'Philodendron cv.', 'Golden Dragon', 'Araceae', 'Philodendron Golden Dragon is a cultivated, vining Philodendron variety that grows in the tropical rainforests. It is a fuss-free plant that needs a minimal amount of care, and it grows quite fast as a climber, making it a perfect choice to hang indoors.', 'vines-and-scramblers', 'med', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (36, 'Chamaedorea Elegans', 'Parlor Palm', 'Arecaceae', 'As the name suggests, this palm is best grown indoors. It is suitable as an indoor plant as it can grow in low light and high humidity. The light-green leaves of the Parlor palm makes a beautiful addition to your living room.', 'trees', 'small', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (37, 'Dracaena Marginata', 'Dragon Tree', NULL, 'Native to Madagascar, the Dragon tree is a spiky tree that looks like a palm. This tree is extremely easy to care for, drought-tolerant and almost indestructible. The slow-growing tree produces white flowers during spring. Please note that this tree is toxic to children and pets, so you should prevent your kids, cats and dogs from eating the leaves or getting too close to the plant.', 'trees', 'small', 'med', 'full', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (38, 'Dypsis Lutescens', 'Areca Palm', NULL, 'This palm is also called the Bamboo palm. It is common as an indoor plant because it has soft fronds and has a tolerance for low light. It looks very much like different types of ponytail palm varieties. You can plant your Areca palm in your bedroom next to the bed. Just make sure that the plant has access to sunlight.', 'trees', 'small', 'high', 'indirect', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (39, 'Chlorophytum Comosum', 'Spider Plant', NULL, 'The weird-looking spider plants are a unique addition to your room. It is very easy to grow because it is highly adaptable to various indoor conditions. The leaves of the plant look scattered and connected at the center just like the web of a spider, which is how it got its name.', 'other', 'small', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (40, 'Crassula Ovata', 'Jade Plant', NULL, 'If you would like to have a beautiful classic plant in your room, then you should grow Jade plants. These plants are exotic and easy to grow, able to thrive in your home or office. It has a similar stem structure to that of Ponytail palms, and its leaves are green, thick and shiny. Jade plants are beautiful and easy to care for, making them perfect for even a beginner plant parent.', 'other', 'small', 'low', 'indirect', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (41, 'Xerophyllum Tenax', 'Bear Grasses', NULL, 'These grasses do not grow to become trees, but when grown properly indoors, their leaves look a lot like the leaves of young Ponytail palm. Bear grasses can grow up to 25 inches long and are easy to care for. ', 'trees', 'small', 'med', 'indirect', 'low', 'med', 'med');
INSERT INTO `plant` VALUES (42, 'Ravenea Rivularis', 'Majesty Palm', NULL, 'This majestic plant is commonly found indoors because it grows slowly and tolerates low light. You can grow this plant in your kitchen, bathroom or any room with high humidity.', 'trees', 'med', 'high', 'indirect', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (43, 'Monstera adansonii variegated', 'Variegated Swiss Cheese Plant ', 'Araceae', 'Monstera plants are native to American rainforests, where they grow as climbers that adhere to the hold by aerial roots. Their common feature is constituted by their large, shiny, perforated leaves that are the reason why plants of this genus are often called “cheese plants.” Young plants grow bushy, with leaves appearing on upright stems. Over time, each stem elongates and grows vertically, so the plant turns into a vine that needs a moss pole support or can be grown in hanging baskets.', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (44, 'Monstera albo borsigiana', 'White Monstera', 'Araceae', 'White monstera is a subspecies of the monstera deliciosa plant. It has big variegated leaves that have large green and pure white patches on them; they can grow to be 10 to 35 inches long and 30 inches wide. The stems of this plant are also quite long and striped, much like its leaves. ', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (45, 'Monstera adansonii acacoyaguensis', 'Swiss Cheese Plant Adansonii', 'Araceae', 'Monstera acacoyaguensis split is a rare tropical plant known for its large foliage and beautiful glossy green leaves. Native to Guatemala and Mexico this climbing plant is easy to grow and is often an attractive centerpiece in all kinds of spaces.', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (46, 'Monstera Karstenianum', 'Monstera Peru', 'Araceae', 'Monstera karstenianum is a rare plant species from Peru that behaves like a succulent and is popular due to its textured green leaves that are patterned with dark-coloured veins. Taking care of this plant is a breeze as it has very minimal care requirements.', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (47, 'Monstera Laniata', 'Swiss Cheese Plant Laniata', 'Araceae', 'This plant is a South American large variety of Swiss cheese plant easy to care for so long as you water it when it needs water and grow it in the right levels of light, temperature, and humidity. The Monstera Laniata is the big-leaved variation of the Monstera adansonii plant and another name for it is Monstera adansonii var. Laniata. However, Monstera Laniata is the most common plant among all the types of Monstera plants in the United States. It is a hemiepiphyte, hence, it grows on trees in some stages of its lifecycle, while it grows on the ground in other states. Even though this plant is difficult to find, it is very easy to care for, furthermore, Monstera laniata is a fast-growing plant so long as you can meet all its needs.', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (48, 'Monstera Epipremnoides', 'Swiss Cheese Plant Epipremnoides', 'Araceae', 'Monstera epipremnoides is a beautiful tropical vine that is commonly known as the swiss cheese plant because of the shape of its leaves. The foliage of the Monstera epipremnoides is large, glossy, and heart-shaped, and it has natural holes that resemble swiss cheese. It is an indoor plant that produces flowers and edible fruits.', 'vines-and-scramblers', 'large', 'high', 'indirect', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (49, 'Monstera Obliqua', 'Cottage Cheese Plant', 'Araceae', 'Monstera Obliqua is a slow-growing, pot-perfect ephemeral that will beautify any home garden. It is epiphytic and to grow on other plants, be stalked or trail from a pot. It needs basic care, like moderate moisture, and it will thrive in your garden. The paper-thin leaves have more holes than the foliage, and it means it needs special care and some expertise to grow it.', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (50, 'Philodendron Hederaceum', 'Sweetheart Plant', 'Araceae', 'Philodendron hederaceum is a beautiful houseplant that is commonly known as the heart-leaf philodendron or sweetheart plant due to its heart-shaped, emerald-colored glossy leaves with pointed tips. Philodendrons are tropical plants that are grown as climbers and form gorgeous vines.', 'vines-and-scramblers', 'small', 'high', 'indirect', 'low', 'med', 'high');
INSERT INTO `plant` VALUES (51, 'Alocasia \'Regal Shields\'', 'Elephant Ear', 'Araceae', 'The Regal Shield is a tropical perennial plant with large, dark-green leaves that almost look black and is a member of the Araceae family in the genus Alocasia that is a cultivar of the Alocasia Odora X and the Alocasia Reginula. These giant leaves grow on big, thick stalks that all connect together at the base of the plant. The Alocasia is a tropical plant native to Eastern Australia and Asia. However, the Regal Shield is a cultivar of the Odora, which comes from Southeast Asia and China, and the Reginula, which is another cultivar of two other Alocasias from Borneo.', 'other', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (52, 'Alocasia \'Black Velvet\'', 'Black Velvet', 'Araceae', 'Alocasia Black Velvet is a stunning indoor plant. It has black, heart-shaped leaves that have some outstanding white or silvery veins on them. This unique trait makes the plant look gorgeous and makes it stand out. The Alocasia Black Velvet plant is toxic, contains oxalic acid. It is highly harmful to humans and pets. Ingestion of these plants may lead to serious health issues. Always keep your kids and pets away from getting too close to the plant.', 'other', 'med', 'high', 'indirect', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (53, 'Calathea zebrina', 'Zebra Plant', 'Marantaceae', 'A favorite among gardeners due to its stunning appearance. It has lush foliage and stunning ovate leaves at the end of slender stalks that are super attractive. The smooth, velvety texture and eye-catching patterns of shades of green give it the look of the stripes of a zebra. The contrasting purple undersides of the leaves add more interest. Calathea zebrina needs proper attention and care when it comes to growing it as a houseplant. Zebra plants love to grow indoors and will tolerate bright light and continue to grow healthy and robust with the right care.', 'other', 'med', 'high', 'indirect', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (54, 'Maranta Leuconeura', 'Maranta Lemon Lime', 'Marantaceae', 'It is one of the most elegant houseplants, which in addition to amazingly variegated leaves, also has an unusual characteristic. When evening comes, it folds the leaves, which in this position resemble hands folded in prayer. With each new morning, the plant drops its leaves again, shoving its remarkable foliage. This peculiarity brought it the name “prayer plant.” Since ancient times, the prayer plant has gained the symbolic status of harbinger of domestic happiness and well-being guardian, specifically because of these unusual movements.', 'other', 'small', 'med', 'shady', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (55, 'Calathea Makoyana', 'Peacock Plant', 'Marantaceae', 'One of the most beautiful varieties of Calathea you can add to your collection with its dazzling display of leaf colors and patterns. It enjoys great popularity among houseplant lovers and collectors, and although it can be a bit high maintenance, it’s not as difficult for beginners as you may think.', 'other', 'med', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (56, 'Ficus Triangularis', 'Sweetheart Tree', 'Ficus', 'At home, they can grow to no more than 1 meter. On average, this evergreen shrub can grow up to 8 feet in height and have a 4-foot spread, growing the characteristics deep green Ficus triangularis leaves. Close up of ficus triangularis plantWhat’s great about this plant is that its leaves won’t drop as quickly as other Ficusses. Furthermore, it’s the leaves that make them well known, as they don unusual rounded-triangular leaves that are thick and tough. The leaves can grow up to 2 or 2.5 inches long and are leaf blade thin with gray-green streaks that split at the top.', 'trees', 'large', 'med', 'shady', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (57, 'Ficus Benghalensis', 'Ficus Audrey', 'Ficus', 'This charming house plant is the national tree of India and became a darling of the gardening world only a few years ago. Finding these plants in your local nursery or garden center is often a challenge due to their current popularity. The Ficus Audrey has brilliant green foliage with thick, creamy, or white veins. The lush leaves accentuate the attractive pale trunk and roots.', 'trees', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (58, 'Begonia Brevirimosa', 'Begonia Brevirimosa', 'Begoniaceae', 'Begonia brevirimosa is a rainforest plant species from Papua New Guinea. The Begonia brevirimosa leaves are large and glossy dark-green with fluorescent-pink variegations making elegant patterns on them. It can be propagated easily using stem or leaf cuttings so you can have multiple plants of this kind if you wish.', 'other', 'med', 'high', 'indirect', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (59, 'Begonia Masoniana', 'Iron Cross Begonia', 'Begoniaceae', 'Begonia masoniana is a notoriously difficult plant to lay your hands on. Nonetheless, it needs only the bare minimum effort and energy on your part to grow and show off its unique foliage. It has asymmetric leaves that are leathery in texture and appear to have bristles when you touch them. The most unique feature is the brown-colored cross present in the middle of apple green leaves.', 'other', 'small', 'high', 'indirect', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (60, 'Begonia coccinea x Begonia aconitifolia', 'Angel Wing Begonia', 'Begoniaceae', 'Angel wing begonia is a tropical houseplant, typically grown for its showy foliage and abundant flower clusters. The angel wing begonia is highly prized for both its blooms and foliage. Its leaves can grow larger than your hand, can have smooth or serrated edges, and have a pointy tip that gives them the shape of a wing. Spotted angel wing begonia cultivars are particularly sought-after for their unique coloring. The leaves and stems of angel wing begonia contain toxic calcium oxalate crystals. Make sure to keep this plant away from cats, dogs, and small children.', 'other', 'med', 'high', 'indirect', 'high', 'med', 'med');
INSERT INTO `plant` VALUES (61, 'Spathiphyllum cochlearispathum', 'Peace Lily', 'Araceae', 'The peace lily is one of the most popular, hardiest and potentially most beautiful of the indoor plants. They offer the best of both worlds: beautiful foliage year-round and gorgeous, generally pure white, flowers over a long period. All parts of Spathiphyllums are mildly poisonous. In rare cases, some people may suffer from contact dermatitis, and eating any parts can cause stomach upsets. Be wary of this around pets – cats especially – as they are inclined to play with the flower spikes.', 'other', 'med', 'high', 'indirect', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (62, 'Monstera Siltepecana', 'Silver Monster', 'Araceae', 'The monstera siltepecana is a tropical plant that thrives on heat and moisture. Related to the philodendron, the monstera likes to climb like a vine and the large green leaves have a silvery hue, which lends to its most common name, silver monster. The evergreen leaves of the monstera genus are unique because as they get older, the silver markings fade. Also, the monstera siltepecana leaves get larger and start to form holes, lending to its other common name, the swiss cheese plant. Out of the 45 types of monstera, the siltepecana is one of the rarest', 'vines-and-scramblers', 'large', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (63, 'Hoya polyneura', 'Wax Plant, Hoya Fishtail', 'Apocynaceae', 'Hoya polyneura is a tropical vining houseplant that is characterized by dark green leaves and long vining stems. The plant is also termed the hoya fishtail due to its thin leaves that resemble a fishtail. It is sometimes also called the wax plant as the flowers look like they have been made out of wax.  The delicate and ornamental hoya fishtail is easy to care for, nonetheless, you wouldn’t find yourself spending hours ensuring they stay healthy. Just focus on giving them their basic requirements and you will be able to witness lush green and beautiful hoya polyneura bloom.', 'vines-and-scramblers', 'small', 'med', 'indirect', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (64, 'Ficus lyrata', 'Fiddle Leaf Fig', 'Ficus', 'Fiddle leaf figs are large spreading evergreen trees that can reach between 15 and 30m tall in tropical climates. Undulate, fiddle-shaped glossy leaves up to 40cm long and 30cm wide form a bushy dome of foliage on top of an upright growing trunk or stem. The fiddle leaf fig is popular as an indoor potted plant and is often used in interior design and styling. It is used as a large specimen plant, growing between 2–3m tall or until it reaches ceiling height.', 'trees', 'large', 'med', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (65, 'Abrophyllum ornans', 'Native Hydrangea', 'Rousseaceae', 'Abrophyllum ornans is a shrub to small tree to 8 m tall. It is grown mainly for its large shiny leaves and showy fruit. The small greenish-yellow to white, and slightly fragrant flowers appear in showy panicles from October to December. It is a useful edge or pioneer species for rainforest restoration.', 'trees', 'large', 'med', 'shady', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (66, 'Acacia dealbata', 'Silver Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia dealbata, Silver Wattle, develops into a medium-sized tree that will reach a height of 30 metres. The flowers are held in globular clusters with 25-35 bright yellow flowers in each cluster. Blooms are carried from late winter to spring.', 'trees', 'large', 'low', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (67, 'Acacia denticulosa', 'Sandpaper Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia denticulosa is an open, somewhat sparse shrub to 4 m high, it is endemic to Western Australia and it listed as threatened with extinction.', 'shrubs-large', 'large', 'med', 'full', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (68, 'Acacia elata', 'Cedar Wattle, Mountain Cedar Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia elata is a long-lived wattle-tree, potentially reaching 30 m. It is endemic to coastal areas of New South Wales from the Budawang Range in the south as afar as the Bellinger River in the north growing in rainforest and wet sclerophyll forests. It is considered a weed in Qld, Vic and WA.', 'trees', 'large', 'low', 'shady', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (69, 'Acacia granitica', 'Granite Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia granitica, the Granite Wattle, comes in two forms. One is a low and spreading shrub with a flat top whilst the other is tall with a rounded growth habit. Both forms have long, narrow, leathery phyllodes with many fine parallel veins. Flower heads are small, ovoid in shape, bright yellow and carried at the base of each phyllode.', 'shrubs-large', 'large', 'low', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (70, 'Acacia ixiophylla', 'Sticky Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia ixiophylla, Sticky Wattle, is a medium, upright shrub. The phyllodes are sticky and about 30 millimetres long by 6 millimetres wide. There is a gland near the base of each phyllode. Bright yellow, globular flowers appear in spring.', 'shrubs-large', 'large', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (71, 'Acacia leptoclada', 'Tingha Golden Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia leptoclada is an attractive, spreading shrub, a native of northern New South Wales. The common name is Tingha Golden Wattle. Tingha is a village near Inverell on the Northern Tablelands of NSW. One of the strongholds of this acacia is the Goonoowigall State Conservation Area. This large, bushland area protects a range of interesting native plants including Acacia leptoclada and is situated near Inverell.', 'shrubs-large', 'large', 'high', 'full', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (72, 'Acacia linifolia', 'White Wattle, Flax-Leaved Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia linifolia is known as the White or Flax-leaved Wattle and is a tall shrub or small tree. In our cold climate garden plants reach a height of four metres. Branches are pendulous. The phyllodes are crowded, linear, flat and up to 40 millimetres long. There is a small, almost obscure, gland near the centre of the phyllodes.', 'trees', 'large', 'high', 'full', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (73, 'Acacia longifolia', 'Sydney Golden Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia longifolia is commonly known as the Sydney Golden Wattle, and is a tall shrub or small tree that may reach a height of seven metres. Bright flowers are carried in spikes with a pair of spikes at the base of each phyllode. In late winter and spring the blooms are both conspicuous and profuse. Straight or curved pods follow the flowers and hold many seeds.', 'trees', 'large', 'low', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (74, 'Acacia longifolia subspecies sophorae', 'Coastal Wattle, Wadanguli (Cadiga)', 'Fabaceae subfamily Mimosoideae', 'Acacia longifolia subsp. sophorae – generally a prostrate shrub when growing on exposed coastal dunes, but may grow as a large shrub to 2-3 metres in height (sometimes taller) in more sheltered locations such as near-coastal forests.', 'shrubs-large', 'large', 'high', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (75, 'Acacia longissima', 'Long-Leaf Wattle, Narrow-Leaf Wattle', 'Fabaceae subfam. Mimosoideae', 'Acacia longissima grows near the coast and is found as far north as Nambour and Nerang in south-eastern Queensland, extending down the south coastal areas of New South Wales to around Batemans Bay. It is often found to inhabit the borders of rainforests in wet or dry sclerophyll forest.', 'trees', 'large', 'low', 'mixed', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (76, 'Acacia Mariae', 'Golden-Top Wattle, Crowned Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia mariae is an erect or spreading shrub to 2 metres high, with smooth bark. It is naturally found mostly in the central and western parts of New South Wales, being fairly common in the Pilliga Scrub, growing in sand. It tends to be found in Eucalyptus–Callitris dry sclerophyll forest, woodland and mallee communities. There are also some North Coast collection records.', 'shrubs-large', 'large', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (77, 'Acacia melanoxylon', 'Mudgerabah, Tasmanian Blackwood, Blackwood Acacia', 'Fabaceae subfamily Mimosoideae', 'Acacia melanoxylon is a tree growing to 30 m tall in a variety of habitats, chiefly in wet sclerophyll forest and in or near cooler rainforest from Queensland to South Australia including Tasmania. In NSW, it is commonly encountered up and down the coast, tablelands and it is scattered on the western slopes.', 'trees', 'large', 'med', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (78, 'Acacia obtusata', 'Blunt-Leaf Wattle, Obtuse Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia obtusata is a shrub, growing with a spindly habit up to 3 m tall and 2 m wide. It grows in NSW on the central and southern tablelands and western edges of coastal subdivisions, from Rylstone district to near Braidwood across to Tumut, common in the western Blue Mountains. Its habitat is chiefly dry sclerophyll woodland and forest.', 'shrubs-large', 'large', 'low', 'full', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (79, 'Acacia obtusifolia', 'Blunt-Leaved Wattle, Stiff-Leaved Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia obtusifolia – grows to a large-shrub or small tree, to 8 m high, usually on sandy and sandstone substrates but also on basalt. It grows in wet and dry sclerophyll forest and margins of rainforest, woodland and heath…', 'trees', 'large', 'low', 'mixed', 'high', 'low', 'med');
INSERT INTO `plant` VALUES (80, 'Acacia oxycedrus', 'Spike Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia oxycedrus is a prickly but interesting wattle, growing to 3 m high by 2 m wide. It is typically found on sandy soils in dry sclerophyll forest or heath in South Australia, Victoria and New South Wales. In NSW, it is mainly confined to the Greater Sydney Basin but with disjunct populations on the far south coast.', 'shrubs-large', 'large', 'low', 'high', 'high', 'low', 'low');
INSERT INTO `plant` VALUES (81, 'Acacia paradoxa', 'Kangaroo Thorn, Paradox Acacia', 'Fabaceae subfamily Mimosoideae', 'Acacia paradoxa is a prickly shrub growing to 4 m high by up to 4 m across. It grows in many different communities in various soil types in WA, Qld, NSW, Vic and SA. It has been introduced into Tasmania for cultivation and has naturalized.', 'shrubs-large', 'large', 'low', 'high', 'high', 'med', 'low');
INSERT INTO `plant` VALUES (82, 'Acacia podalyriifolia', 'Queensland Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia podalyriifolia grows to 6 m high and wide, in open forest and woodland in south eastern Queensland and just into the top of NSW on the North Coast.', 'trees', 'large', 'low', 'mixed', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (83, 'Acacia pravissima', 'Ovens Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia pravissima is a tree growing to 8 m tall and potentially 5 m wide, it grows in sclerophyll forests and woodland, in clays and sandy loams on riverbanks, hillslopes and ridges. It grows on the southern tablelands and western slopes of NSW, south from the ACT, extending into Victoria.', 'trees', 'large', 'low', 'mixed', 'med', 'high', 'low');
INSERT INTO `plant` VALUES (84, 'Acacia pycnantha', 'Golden Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia pycnantha, Golden Wattle, is Australia’s floral emblem. Golden Wattle develops into a tall shrub reaching a height of eight metres. Golden yellow flowers are held in large clusters that may hold up to 60 individual flowers. They cover plants in spring.', 'shrubs-large', 'large', 'low', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (85, 'Acacia saliciformis', 'Willow Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia saliciformis is an attractive small tree or large shrub growing to 7 m with smooth, greyish bark and a weeping habit. It grows in wet and dry sclerophyll forest, in gravelly, sandy and clay loam soils. It is found in parts of NSW from Bilpin in the south to around Bulga in the north, and possibly also growing in the Budawang Ranges. It has red new growth in spring.', 'shrubs-large', 'large', 'low', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (86, 'Acacia schinoides', 'Green Cedar Wattle, Frosty Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia schinoides is an erect tree or shrub 10 m high and 7 m wide. It is restricted to coastal central NSW., north-western Cumberland Plain, Hornsby Plateau and the Hunter River Valley (Lane Cove to Maitland) growing in deep shady gullies usually near creeks. It has naturalised into coastal Victoria.', 'trees', 'large', 'low', 'mixed', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (87, 'Acacia terminalis', 'Sunshine Wattle', 'Fabaceae subfamily Mimosoideae', 'Acacia terminalis is a variable plant in habit, ranging from a small shrub about 1 metre in height to a large shrub up to about 5 metres tall. Widespread in open forest and woodland from northern New South Wales to Tasmania, mainly on the coast and tablelands, usually on sandy soils or sandstone.', 'shrubs-large', 'large', 'low', 'mixed', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (88, 'Acmena smithii', 'Lilly Pilly, Midjuburi (Cadigal)', 'Myrtaceae', 'Acmena smithii – An attractive shrub or tree-myrtle, reaching 30 metres tall. It has a general lilly pilly appearance. Can spread to 10 m wide or more.', 'trees', 'large', 'high', 'full', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (89, 'Acronychia oblongifolia', 'White Aspen, Yellow Wood', 'Rutaceae', 'Acronychia oblongifolia – A tree growing to 25 m or so tall, from near Gympie in central-eastern Queensland, south through the extent of coastal New South Wales to a few rainforest communities in eastern Victoria. Its natural habitat is rainforest and rainforest margins.', 'trees', 'large', 'low', 'full', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (90, 'Actinotus minor', 'Lesser Flannel Flower', 'Apiaceae', 'Actinotus minor a spreading perennial wiry herb, erect to spreading horizontally, 15–50 cm high, with long slender stems.', 'ground-covers', 'med', 'med', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (91, 'Aegiceras corniculatum', 'Black Mangrove', 'Primulaceae', 'Aegiceras corniculatum grows as a shrub or small tree up to 7 metres high (but typically about 2 m) in NSW, Qld, WA and NT along the coast in tidal areas, and extending into south east Asia. Its fragrant, small, white flowers are produced as umbellate clusters of 10 to 30.', 'trees', 'large', 'low', 'mixed', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (92, 'Ajuga australis', 'Austral Bugle', 'Lamiaceae', 'Ajuga australis – A highly variable widespread species occurring in all regions of New South Wales, also in Queensland, Victoria, Tasmania, and South Australia. It can be found in a range of soils and habitats from coastal forests to the dry, mallee country.', 'ground-covers', 'med', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (93, 'Alchornea ilicifolia', 'Native Holly', 'Euphorbiaceae', 'Alchornea ilicifolia – A small tree, to 6 metres tall. Found naturally in or on the edges of the drier rainforests; as far south as Jamberoo, New South Wales, north along the coast and extending west into the Hunter Valley, to Atherton in Queensland.', 'trees', 'large', 'low', 'shady', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (94, 'Allocasuarina grampiana', 'Grampian’S Sheoak', 'Casuarinaceae', 'Allocasuarina grampiana is known as the Grampian’s Sheoak and is a tall shrub or small tree with distinctive blue-grey foliage this is due to a waxy bloom. In common with many Sheoaks this species is dioecious (male and female flowers are carried on separate plants). Male flowers are carried on the ends of branches in long spikes. When mature, pollen is released and carried by the wind. Female flowers are red with numerous styles giving them a sea-urchin appearance.', 'trees', 'large', 'low', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (95, 'Alpinia arundelliana', 'Native Ginger', 'Zingiberaceae', 'Alpinia arundelliana is an understorey perennial lily-type plant (not woody) growing to 2 m high in rainforest or wet sclerophyll forest; north from Wyong north into Queensland. It is only found in coastal areas.', 'grasses-and-clumping', 'med', 'med', 'shady', 'med', 'high', 'low');
INSERT INTO `plant` VALUES (96, 'Angophora hispida', 'Dwarf Apple', 'Myrtaceae', 'Angophora hispida – A small tree or mallee, capable of reaching 7 to 10 metres tall but often seen much smaller, forming a lignotuber. It sometimes has a wide spread for a small tree.', 'trees', 'large', 'high', 'full', 'med', 'high', 'med');
INSERT INTO `plant` VALUES (97, 'Angophora subvelutina', 'Broad-Leaved Apple', 'Myrtaceae', 'Angophora subvelutina – a large tree up to 20 m tall. It is a widespread tree but is found primarily in coastal subdivisions, growing north from Araluen on the NSW south coast, along the central and north coasts into Queensland to around the Sunshine Coast and inland', 'trees', 'large', 'high', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (98, 'Archirhodomytus beckleri', 'Rose Myrtle', 'Myrtaceae', 'Archirhodomytus beckleri belongs to the Myrtaceae family and is the only species of Archirhodomytus growing in Australia. The other four species are from New Caledonia. The common name for this plant is Rose Myrtle and I suspect this name refers to the lovely fragrance of the flowers especially early in the morning before the day warms up.', 'shrubs-large', 'large', 'med', 'direct', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (99, 'Asterolasia beckersii', 'Dungowan Star Bush', 'Rutaceae', 'Asterolasia beckersii, or Dungowan Star Bush is a very rare plant from an area near Tamworth, New South Wales and is a member of the Rutaceae family. The Dungowan Star Bush is an erect shrub, reaching a height of two to three metres. The leaves are oblong in shape tapering to the short petiole and have an elliptic lamina. The upper surface is green whilst the lower surface is paler green to fawn. The stems tend to be covered in a rusty brown indumentum.', 'shrubs-large', 'large', 'low', 'full', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (100, 'Austromyrtus tenuifolia', 'Narrow Leafed Myrtle', 'Myrtaceae', 'Austromyrtus tenuifolia naturally grows in wet sclerophyll forests, often beside streams or in damp places in the Sydney Basin. My plant, is now many years old and is growing in my northern suburbs Sydney’s garden, on a thinnish layer of soil over a clay base in a position that is often quite dry compared to its natural habitat.', 'shrubs-large', 'large', 'low', 'mixed', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (101, 'Backhousia citriodora', 'Lemon-Scented Myrtle', 'Myrtaceae', 'Backhousia citriodora belongs to the Myrtaceae family and is endemic to central and southern Queensland (Mackay to Brisbane). My plant is about four metres high and two metres wide and produces masses of white fluffy flowers, about one centimetre in diameter, near the end of the branchlets, in November to December. This plant is popular in cultivation for its bushy habitat, branches to ground level and strongly lemon scented leaves (that can be used in cooking).', 'trees', 'large', 'med', 'full', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (102, 'Backhousia myrtifolia', 'Grey Myrtle, Cinnamon Myrtle', 'Myrtaceae', 'Backhousia myrtifolia – An attractive shrub or tree-myrtle, reaching 30 metres tall. It has a general lilly-pilly appearance. Can spread to 10 m wide or more. The bark is brown with finely flaky bark.', 'trees', 'large', 'low', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (103, 'Baeckea linifolia', 'Flax-Leaf Heath Myrtle, Swamp Myrtle', 'Myrtaceae', 'Baeckea linifolia is found in heaths, usually in damp areas and near sandstone waterfalls and creeks (coast and tablelands), from south-east Queensland to eastern Victoria where it is rare. It is an ideal screen plant, occasionally self-seeds and the flowers attract bees.', 'shrubs-large', 'large', 'high', 'full', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (104, 'Banksia aemula', 'Wallum Banksia', 'Proteaceae', 'Banksia aemula – A tree capable of reaching 8 metres tall in the wild and a canopy spread to 5 m.', 'trees', 'large', 'low', 'full', 'low', 'high', 'high');
INSERT INTO `plant` VALUES (105, 'Banksia blechnifolia', 'Fern-Leaved Banksia, Groundcover Banksia', 'Proteaceae', 'Banksia blechnifolia – A prostrate banksia from WA which generates much interest as it grows along the ground.', 'shrubs-small', 'small', 'high', 'full', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (106, 'Banksia collina', 'Hairpin Banksia', 'Proteaceae', 'Banksia collina – Typically, a multi-stemmed shrub to 3 m tall, bearing a lignotuber.', 'shrubs-large', 'large', 'high', 'full', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (107, 'Banksia integrifolia', 'Coast Banksia', 'Proteaceae', 'Banksia integrifolia – A shrub to tree, growing to potentially 25 m with tessellated or fissured bark. It is found only on sandy soils, close to the beach on the coast as well as some inland sandy environments (eg: Warkworth Sands Woodland in the Hunter Valley).', 'trees', 'large', 'med', 'full', 'low', 'high', 'med');
INSERT INTO `plant` VALUES (108, 'Banksia marginata', 'Silver Banksia, Honeysuckle', 'Proteaceae', 'Banksia marginata – A shrub to tree, growing to 12 m tall with tessellated bark. It has a much wider distribution compared to other banksias…', 'trees', 'large', 'med', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (109, 'Banksia spinulosa', 'Hairpin Banksia', 'Proteaceae', 'Banksia spinulosa grows mostly on the central and south coast subdivisions of NSW, extending into the tablelands where records are fewer, also extending up the north coast into Queensland, with disjunct populations up to about Townsville.', 'shrubs-large', 'large', 'med', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (110, 'Banksia vincentia', 'Vincentia Banksia', 'Proteaceae', 'Banksia vincentia – A very rare banksia, only recently found in the wild, which grows to only 1 m tall but can spread to 2 m wide, bearing a lignotuber. It has mostly prostrate stems which curve up (decumbent) at terminals.', 'shrubs-small', 'small', 'med', 'full', 'low', 'high', 'med');
INSERT INTO `plant` VALUES (111, 'Bauera rubioides', 'Dog Rose, River Rose', 'Cunoniaceae', 'Bauera rubioides An attractive border plant if pruned, otherwise it likes to scramble all over the place, if ample moisture is available. Prune after flowering to keep compact. Bauera rubioides occurs in coastal heaths and forest of New South Wales, Victoria, Tasmania, South Australia and Queensland. It grows along the entire coast and tablelands of NSW, usually on sandstone creek lines and heathlands.', 'shrubs-large', 'large', 'high', 'mixed', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (112, 'Billardiera cymosa', 'Sweet Apple Berry', 'Pittosporaceae', 'Billardiera cymosa is known as the Sweet Apple Berry and is a member of the Pittosporaceae family. The Sweet Apple Berry is a slender climber. Leaves are narrow-lanceolate and about seven centimetres long. Young shoots are covered with silky hairs. Tip pruning will increase foliage density.', 'vines-and-scramblers', 'med', 'low', 'mixed', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (113, 'Billardiera scandens ‘Apple Dumplings’', 'Common Apple Berry', 'Pittosporaceae', 'Billardiera scandens ‘Apple Dumplings’, the Common Apple Berry or Apple Dumpling, is a member of the Pittosporaceae family. Common Apple Berry is a slender climber. Stems may reach three metres in length. Common Apple Berry is a slender climber. Stems may reach three metres in length. Leaves are linear-lanceolate, up to three centimetres long, glossy dark green with wavy margins. Juvenile shoots are very hairy. In open positions plants may develop into a small shrub 1.5 metres tall.', 'vines-and-scramblers', 'med', 'low', 'mixed', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (114, 'Boronia pinnata', 'Boronia', 'Rutaceae', 'Boronia pinnata is a shrub reaching a height of 1.5 metres. The leaves are pinnate with 5-11 leaflets. The flowers are carried in clusters held in the upper leaf axils. Each flower is about 1.5 centimetres in diameter, four-petalled and pale to deep pink in colour. A white-flowered form is also in cultivation. Flowers are both conspicuous, profuse and appear in spring. Both foliage and flowers are strongly aromatic.', 'shrubs-large', 'large', 'med', 'mixed', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (115, 'Boronia serrulata', 'Native Rose, Rose Boronia', 'Rutaceae', 'A shrub growing usually to about 1.5 m tall. It has a comparatively small natural distribution, growing between Gosford and Wollongong…', 'shrubs-large', 'large', 'low', 'full', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (116, 'Boronia thujona', 'Bronzy Boronia', 'Rutaceae', 'Potentially a tall shrub, that grows to a height of 4 metres. It is confined to eastern NSW…', 'shrubs-large', 'large', 'high', 'mixed', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (117, 'Brachyscome graminea', 'Stiff Daisy, Grass Daisy', 'Asteraceae', 'Brachyscome graminea is a herbaceous daisy and groundcover, growing in open forests from coasts to alpine areas of New South Wales, Victoria, Tasmania and South Australia. In NSW, it grows mainly on the coast and tablelands.', 'ground-covers', 'med', 'med', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (118, 'Brachyscome multifida', 'Cut-Leaf Daisy', 'Asteraceae', 'Brachyscome multifida, the Cut-leaf Daisy, is a hardy and colourful perennial. It develops into a dense, ground covering mound reaching a height of 30 centimetres with a diameter approaching a metre. Foliage is light green. In spring and summer plants are covered with mauve-pink flowers. A great groundcover or edging plant in the garden.', 'ground-covers', 'med', 'low', 'full', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (119, 'Bulbine bulbosa', 'Bulbine Lily, Wild Onion, Golden Lily', 'Asphodelaceae', 'Bulbine bulbosa grows throughout temperate Australia from central Queensland to Tasmania and South Australia as well as all over NSW, usually on heavier soils. It grows in a variety of habitats including dry sclerophyll woodlands and forests as well as grasslands and rock crevices. It can be found in large numbers in cleared and regenerating open grassy areas after rain.', 'grasses-and-clumping', 'med', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (120, 'Bursaria spinosa', 'Blackthorn', 'Pittosporaceae', 'Bursaria spinosa is known as the Blackthorn and also the Tasmanian and South Australian Christmas Bush because summer is the main flowering period of this prickly plant. Blackthorn develops into a medium to tall shrub with oval leaves, shiny on top and dull underneath. The branches carry large spines.', 'shrubs-large', 'large', 'low', 'full', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (121, 'Callistemon brachyandrus', 'Mallee Bottlebrush, Prickly Bottlebrush', 'Myrtaceae', 'Callistemon brachyandrus has a number of common names including: Mallee Bottlebrush, Prickly Bottlebrush and Prickly Mallee Bottlebrush. It is usually a small to medium shrub with small prickly leaves. Young growth is softly hairy.', 'shrubs-small', 'small', 'low', 'mixed', 'low', 'med', 'low');
INSERT INTO `plant` VALUES (122, 'Callistemon Citrinus', 'Crimson Bottlebrush', 'Myrtaceae', 'Callistemon citrinus syn: Melaleuca citrina produces flowers in late spring, summer and autumn with two flowerings if some moisture is provided. There are many hybrids produced using this plant as a parent. A popular cultivar is Callistemon ‘Endeavour’ which can have bright metallic red/pink inflorescences.', 'shrubs-large', 'large', 'low', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (123, 'Callistemon comboynensis', 'Cliff Bottlebrush', 'Myrtaceae', 'Callistemon comboynensis is known as the Cliff Bottlebrush and grows into a medium shrub reaching a height of three metres. The leaves are narrow to broad-lanceolate, leathery with numerous oil dots. New growth is pinkish. The flower spikes are red, five to nine centimetres long and between four to eight centimetres wide. The main flowering period is in summer and autumn with sporadic flowering at other times.', 'shrubs-large', 'large', 'high', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (124, 'Callistemon flavovirens', 'Green Bottlebrush', 'Myrtaceae', 'Callistemon flavovirens is a spreading shrub that can reach a height of two metres with a similar spread. New growth is soft and has a silvery appearance. Adult leaves are dark green, narrow elliptical, up to eight centimetres long and widely spaced along the branches. The greenish-yellow flower spikes are about eight centimetres long.', 'ground-covers', 'med', 'high', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (125, 'Callistemon formosus', 'Cliff Bottlebrush, Kingaroy Bottlebrush', 'Myrtaceae', 'Callistemon formosus is known as the Cliff Bottlebrush or Kingaroy Bottlebrush. The latter common name refers to a town in southern Queensland near where the species occurs. It is a tall shrub that may reach a height of five metres with a spread of three metres and pendulous growth habit. The specimens, in our cold climate garden, are two metres tall four years after planting.', 'shrubs-large', 'large', 'med', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (126, 'Callistemon rugulosus', 'Scarlet Bottlebrush', 'Myrtaceae', 'Callistemon rugulosus is known as the Scarlet Bottlebrush and in the wild will develop into a straggly shrub up to four metres tall. In our cold climate garden annual pruning has kept this species to a compact two metres. The bark is grey and peels. The leaves are thick and rigid, up to 50 millimetres long, seven millimetres wide and crowned with a pungent point.', 'shrubs-large', 'large', 'med', 'mixed', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (127, 'Callistemon salignus', 'Willow Bottlebrush', 'Myrtaceae', 'Callistemon salignus is known as the Willow Bottlebrush. The species name means willowy and refers to the growth habit. Callistemon salignus is a tall shrub or small tree. The brushes are creamy-white to yellow, five centimetres long by three centimetres wide and appear in spring. Brushes are usually abundant and conspicuous. Sometimes there are sporadic blooms in autumn.', 'trees', 'large', 'low', 'full', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (128, 'Callistemon serpentinus', 'Wood’s Reef Bottlebrush', 'Myrtaceae', 'Callistemon serpentinus s known as the Wood’s Reef Bottlebrush and is an upright shrub that may reach a height of four metres. Our specimens are kept to a dense height of two metres by annual pruning. Yellow flower spikes are about six centimetres long and appear in late spring and early summer. Flower spikes are both prominent and conspicuous.', 'shrubs-large', 'large', 'med', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (129, 'Callitris endlicheri', 'White Cypress Pine', 'Cupressaceae', 'Callitris endlicheri is known as the Black Cypress Pine and reaches a maximum height of about 15 metres. The branches are erect sometimes spreading; the bark is tough and deeply furrowed. The foliage is bright green. The female cones may be solitary or several clustered together. They are egg-shaped and contain a number of sticky seeds that are coated in resin. Cones persist on the tree for a number of years.', 'trees', 'large', 'low', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (130, 'Callitris rhomboidea', 'Port Jackson Pine', 'Cupressaceae', 'Callitris rhomboidea s known as the Port Jackson Pine or Oyster Bay Pine. The common name depends on the location of the species. The former name refers to populations in NSW whist the latter common name refers to those in Tasmania. We will stick to Port Jackson Pine because of our location. The Port Jackson Pine is a small tree that may reach a height of 15 metres. Mature trees have an attractive pyramid shape.', 'trees', 'large', 'low', 'full', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (131, 'Calytrix tetragona', 'Fringe Myrtle', 'Myrtaceae', 'Calytrix tetragona is the most widespread member of the genus Calytrix which has about 75 species, all endemic to Australia. This species is found in woodland and forest in eastern and southern Australia.', 'shrubs-large', 'large', 'high', 'mixed', 'med', 'high', 'low');
INSERT INTO `plant` VALUES (132, 'Carex gaudichaudiana', 'Tufted Sedge, Fen Sedge', 'Cyperaceae', 'Carex gaudichaudiana is a loosely-tufted sedge to 40 cm tall with creeping rhizome. It grows in wet areas (swamps and creekbanks) from near sea level to alpine areas.', 'grasses-and-clumping', 'med', 'low', 'full', 'high', 'high', 'low');
INSERT INTO `plant` VALUES (133, 'Cissus hypoglauca', 'Water Vine, Native Grape', 'Vitaceae', 'Cissus hypoglauca – A vigorous common vine, found along almost the entire east coast of NSW, from south of Townsville to eastern Victoria, growing in warmer rainforest but also found in littoral rainforest near beaches and wet sclerophyll forest.', 'vines-and-scramblers', 'med', 'high', 'shady', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (134, 'Citrus australasica', 'Finger Lime', 'Rutaceae', 'Citrus australasica, finger lime, seems to me to be pretty easy to grow. Mine is now about 5 years old, and has been flowering and bearing fruit for the last three years. I would guess that it is a grafted specimen, although it doesn’t say that on the label.', 'trees', 'large', 'low', 'mixed', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (136, 'Coronidium elatum', 'White Everlasting Daisy', 'Asteraceae', 'Coronidium elatum is a perennial that may reach a height of two metres. Both stems and leaves are covered with white hairs, giving plants a woolly appearance. Leaves are lanceolate and up to ten centimetres long. Papery white flower-heads up to four centimetres across appear in spring.', 'ground-covers', 'med', 'low', 'mixed', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (137, 'Correa alba', 'Correa', 'Rutace', 'Correa alba is a rounded, dense shrub that may reach a height of three metres. In our cold climate garden specimens reach a height of about two metres. Leaves are almost circular, greyish-green with a rounded end. The flowers are not typical tubular Correa flowers. Correa alba has blooms that are more flattened and star-shaped. They are usually white with some forms having blooms with a pink tinge. The main flowering period covers autumn and winter with sporadic flowering at other times.', 'shrubs-small', 'small', 'low', 'shady', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (138, 'Correa baeuerlenii', 'Chef’s Cap Correa', 'Rutaceae', 'Correa baeuerlenii, the Chef’s Cap Correa, is a dense, rounded shrub reaching a height of two metres. We lightly prune our specimens and keep them to a dense 1.5 metres. Leaves are narrowly ovate, up to seven centimetres long, glossy, with prominent glands on each surface and slightly aromatic when crushed. Tubular flowers are greenish yellow, about three centimetres long, solitary and pendulous.', 'shrubs-large', 'large', 'med', 'shady', 'low', 'low', 'low');
INSERT INTO `plant` VALUES (139, 'Correa glabra', 'Rock Correa', 'Rutaceae', 'Correa glabra is a tall shrub, endemic to Australia (NSW, Queensland, Victoria, South Australia) with attractive, quite vibrant elliptic leaves, 1 to 4 cm long and 5 to 17 mm wide. They will grow in a variety of soil types as long as the soil is well drained. They are very ‘prune-able’ and shoot from old wood.', 'shrubs-large', 'large', 'med', 'mixed', 'med', 'low', 'low');
INSERT INTO `plant` VALUES (145, 'Crinum pedunculatum', 'Swamp Lily, River Lily', 'Amaryllidaceae', 'Crinum pedunculatum is a member of the Amaryllidaceae family in company with the exotic Narcissus and Nerine. The accepted common names are Swamp or River Lily. Crinum pedunculatus grows in colonies along tidal areas and streams. The species is evergreen, hardy and resists frost.', 'grasses-and-clumping', 'med', 'med', 'full', 'med', 'med', 'low');
INSERT INTO `plant` VALUES (146, 'Cyanothamnus nanus var. hyssopifolius', 'Dwarf Boronia', 'Rutaceae', 'A shrub to 0.3 metres high, erect or sprawling to prostrate. It is found as far north as Mt Wilson west of Sydney, growing south-south-west from here mostly in the tablelands regions', 'shrubs-small', 'small', 'med', 'mixed', 'med', 'high', 'low');
INSERT INTO `plant` VALUES (147, 'Cyanothamnus quadrangulus', 'Narrow-Leaved Boronia', 'Rutaceae', 'A small shrub growing to 1 metre tall by up to 1 metre wide with square / 4-angled branches.', 'shrubs-small', 'small', 'med', 'mixed', 'med', 'high', 'low');
INSERT INTO `plant` VALUES (148, 'Dampiera purpurea', 'Mountain, Purple Dampier', 'Goodeniaceae', 'Dampiera purpurea is widespread in open eucalypt woodland in Victoria, New South Wales and Queensland in eastern Australia. A small perennial suckering shrub that reaches 1 to 1.5 metres high and can spread to 2 metres across. It has erect angular woody stems that are sparsely branched and densely hairy. Leaves are 1–6 cm long, 0.5–2.5 cm wide.', 'shrubs-small', 'small', 'low', 'mixed', 'low', 'high', 'low');
INSERT INTO `plant` VALUES (149, 'Eucalyptus kruseana', 'Bookleaf Mallee', 'Myrtaceae', 'Eucalyptus kruseana would be one of the best eucalypts for cultivation in suburban gardens. Unpruned plants may become straggly. This is prevented, once plants are established, by cutting back each stem almost to ground level. This will encourage multi-stemmed (mallee) growth.', 'shrubs-large', 'large', 'low', 'direct', 'low', 'low', 'med');
INSERT INTO `plant` VALUES (155, 'Grevillea lanigera ‘Mt Tamboritha’', 'Spider Flower', 'Proteaceae', 'Grevillea lanigera ‘Mt Tamboritha’ make an excellent compact ground cover as they grow to about one metre (or less) in diameter to about 20 cms high in situations with full sun to partial shade in fairly well drained soils. Its attractive grey/green foliage is a good colour contrast to its flowers, and is best shown if planted in groups of three.', 'shrubs-small', 'small', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (156, 'Grevillea linearifolia', 'White Spider Flower', 'Proteaceae', 'Grevillea linearifolia – Is an upright spreading shrub up to about 2 to 3 m high. It is found naturally, primarily in the Greater Sydney Basin, from Gosford and Putty area to the Parramatta River and Port Jackson, then with disjunct populations near Nowra and Ulladulla as well as Lawson in the Blue Mountains.', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (157, 'Grevillea molyneuxii', 'Wingello Grevillea', 'Proteaceae', 'Grevillea molyneuxii – A low spreading shrub to 1 m tall. Restricted to a small area in the southern highlands of NSW, viz. south of Penrose, above Tallowa Gully and Bundanoon Creek, in Morton National Park and on Crown Land.', 'shrubs-small', 'small', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (158, 'Grevillea mucronulata', 'Green Spider Flower', 'Proteaceae', 'Grevillea mucronulata is a spreading to erect shrub which usually grows up to 2 m high. Its primary natural range is from the upper Hunter Region around Denman and Singleton, west to Rylstone…', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (159, 'Hakea laevipes', 'Finger Hakea', 'Proteaceae', 'Hakea laevipes – An erect and bushy shrub to 3 metres tall, possessing a lignotuber. It is found growing in eastern NSW, in disjunct locations on sandy soils in dry sclerophyll forest, woodland and heath. It also grows in south-east Qld.', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (160, 'Hakea nodosa', 'Yellow Hakea', 'Proteaceae', 'Hakea nodosa, Yellow Hakea, is a shrub reaching a height of two metres. Leaves are up to five centimetres long, light green, usually needle-like but sometimes flattened. Yellow flowers are carried in clusters in the leaf axils. They clothe the branches from May to August.', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (162, 'Isopogon formosus', 'Rose Cone-Flower', 'Proteaceae', 'Isopogon formosus is a small, erect or spreading shrub that may reach a height of 1.5 metres and is known as the Rose Cone-flower. The young growth is silky and sometimes reddish. Adult leaves are green to reddish-green, very divided and each segment has a sharp point.', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (163, 'Leptospermum emarginatum', 'Twin-Flower Teatree', 'Myrtaceae', 'A large shrub growing to 4 metres tall by 2 metres wide. It has a natural distribution of usually being within 100 km of the coast, extending south from Wisemans Ferry and Katoomba in the Greater Sydney area', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (164, 'Leptospermum macrocarpum', 'Large-Fruited Teatree', 'Myrtaceae', 'A shrub to 2 metres tall by 2 metres wide, with rough and gnarled bark. It has a limited distribution, growing mainly in the greater Blue Mountains of Sydney, from Springwood to Lithgow and into Kurrajong and Mt Wilson…', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (166, 'Melaleuca fulgens', 'Scarlet Honey-Myrtle', 'Myrtaceae', 'Melaleuca fulgens, known as the Scarlet Honey-myrtle, is an erect shrub reaching a height of three metres. The leaves are narrow, aromatic and up to four centimetres long. Flowers may be scarlet, pinkish-red, apricot or purple.', 'shrubs-large', 'large', 'low', 'shady', 'med', 'med', 'med');
INSERT INTO `plant` VALUES (167, 'Melaleuca hypericifolia', 'Hillock Bush, Honey Myrtle', 'Myrtaceae', 'A large woody shrub or small tree growing to potentially 6 metres in height; often seen as a sprawling shrub to about 3 metres tall and 2 metres wide, with papery bark.', 'shrubs-large', 'large', 'low', 'shady', 'low', 'med', 'med');
INSERT INTO `plant` VALUES (168, 'Ozothamnus diosmifolius', 'Sago Flower, Rice Flower', 'Asteraceae', 'Ozothamnus diosmifolius is a shrub that will reach a height of 2 metres. Flowers appear in winter and spring at the ends of branches in dense globular clusters. Buds may be pink and they open to small white to pink flowers. What the flowers lack in size they make up for in quantity.', 'shrubs-small', 'small', 'low', 'shady', 'low', 'low', 'med');
INSERT INTO `plant` VALUES (169, 'Pandorea pandorana', 'Wonga Vine', 'Bignoniaceae', 'Pandorea pandorana, Wonga Vine, is a member of the Bignoniaceae family. This woody scrambler or climber has long, twining branches with fawn coloured bark. Flowers are tubular, about two centimetres long, usually creamy-white with either brown or purple markings in the throat.', 'vines-and-scramblers', 'med', 'low', 'shady', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (170, 'Philotheca buxifolia', 'Cascade of Stars', 'Rutaceae', 'A naturally compact and delightful small shrub with a cascading habit, and aromatic light green foliage. It gets masses of soft pink buds in early spring which open to white star shaped flowers in mid to late spring. It needs a well drained soil in a sunny to part shaded spot, and will cope with dry spells once it becomes established. Great for containers and on banks and walls where it can spill over, as a feature plant or mass planted. Mulch to suppress weeds, add organic matter and to cool the soil, this also helps to avoid root disturbance. A good easy care plant.', 'shrubs-small', 'small', 'low', 'shady', 'low', 'low', 'high');
INSERT INTO `plant` VALUES (171, 'Pittosporum multiflorum', 'Wallaby Apple, Orange Thorn', 'Pittosporaceae', 'Pittosporum multiflorum – A stiff, wiry shrub up to 3 m high, with thorny branches. It is found in or near rainforest or wet sclerophyll forest, typically on enriched soils (shale and volcanic loams).Can also thrive in cleared rainforest areas. It grows north of Bega in NSW, extending mainly along the coast, into Queensland to around the Sunshine Coast.', 'shrubs-large', 'large', 'high', 'shady', 'med', 'high', 'med');
INSERT INTO `plant` VALUES (175, 'Themeda triandra', 'Kangaroo Grass', 'Poaceae', 'Themeda triandra is a tufted perennial reaching a height of 1.5 metres with a spread of 0.5 metres. Leaves are 10-50 cm long and 2-5 mm wide, green to grey and dry to an orange-brown in summer. The flowering period is from December to February. During this time plants produce large, distinctive, red-brown spikelets carried on branched stems. Spikelets have black awns (see image) that are retained by the seeds when shed. The spikelets make this perhaps the easiest of our native grasses to identify.', 'grasses-and-clumping', 'med', 'low', 'shady', 'low', 'med', 'med');
INSERT INTO `plant` VALUES (176, 'Viola hederacea', 'Native Violet', 'Violaceae', 'Viola hederacea is an evergreen tufted ground cover, which grows to 10 cm tall but may spread to form a colony several metres wide, spreading by stolons. It has round to kidney-shaped (reniform) leaves, to 3 cm wide, with variable toothing on the margins.', 'ground-covers', 'med', 'low', 'shady', 'med', 'med', 'high');
INSERT INTO `plant` VALUES (178, 'Philotheca myoporoides', 'Bournda Beauty', 'Rutaceae', 'A hardy small shrub that adapts well to a wide range of environments. Profuse flowering is a feature. Great plant for a shrubbery or pot, and can be trimmed to shape the plant if desired, though untrimmed plants are quite attractive as well. The blooms make good cut flowers, and the foliage is also useful as a filler in flower bunches. The foliage has an aromatic perfume.', 'shrubs-small', 'small', 'low', 'shady', 'low', 'low', 'high');

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

INSERT INTO `plant_location` VALUES (35, 'indoors');
INSERT INTO `plant_location` VALUES (35, 'outdoors');
INSERT INTO `plant_location` VALUES (36, 'indoors');
INSERT INTO `plant_location` VALUES (37, 'indoors');
INSERT INTO `plant_location` VALUES (38, 'indoors');
INSERT INTO `plant_location` VALUES (39, 'indoors');
INSERT INTO `plant_location` VALUES (40, 'indoors');
INSERT INTO `plant_location` VALUES (41, 'indoors');
INSERT INTO `plant_location` VALUES (42, 'indoors');
INSERT INTO `plant_location` VALUES (43, 'indoors');
INSERT INTO `plant_location` VALUES (43, 'outdoors');
INSERT INTO `plant_location` VALUES (44, 'indoors');
INSERT INTO `plant_location` VALUES (44, 'outdoors');
INSERT INTO `plant_location` VALUES (45, 'indoors');
INSERT INTO `plant_location` VALUES (45, 'outdoors');
INSERT INTO `plant_location` VALUES (46, 'indoors');
INSERT INTO `plant_location` VALUES (46, 'outdoors');
INSERT INTO `plant_location` VALUES (47, 'indoors');
INSERT INTO `plant_location` VALUES (47, 'outdoors');
INSERT INTO `plant_location` VALUES (48, 'indoors');
INSERT INTO `plant_location` VALUES (48, 'outdoors');
INSERT INTO `plant_location` VALUES (49, 'indoors');
INSERT INTO `plant_location` VALUES (49, 'outdoors');
INSERT INTO `plant_location` VALUES (50, 'indoors');
INSERT INTO `plant_location` VALUES (50, 'outdoors');
INSERT INTO `plant_location` VALUES (51, 'indoors');
INSERT INTO `plant_location` VALUES (52, 'indoors');
INSERT INTO `plant_location` VALUES (53, 'indoors');
INSERT INTO `plant_location` VALUES (54, 'indoors');
INSERT INTO `plant_location` VALUES (55, 'indoors');
INSERT INTO `plant_location` VALUES (56, 'indoors');
INSERT INTO `plant_location` VALUES (56, 'outdoors');
INSERT INTO `plant_location` VALUES (57, 'indoors');
INSERT INTO `plant_location` VALUES (57, 'outdoors');
INSERT INTO `plant_location` VALUES (58, 'indoors');
INSERT INTO `plant_location` VALUES (59, 'indoors');
INSERT INTO `plant_location` VALUES (60, 'indoors');
INSERT INTO `plant_location` VALUES (61, 'indoors');
INSERT INTO `plant_location` VALUES (62, 'indoors');
INSERT INTO `plant_location` VALUES (62, 'outdoors');
INSERT INTO `plant_location` VALUES (63, 'indoors');
INSERT INTO `plant_location` VALUES (64, 'indoors');
INSERT INTO `plant_location` VALUES (64, 'outdoors');
INSERT INTO `plant_location` VALUES (65, 'indoors');
INSERT INTO `plant_location` VALUES (65, 'outdoors');
INSERT INTO `plant_location` VALUES (66, 'outdoors');
INSERT INTO `plant_location` VALUES (67, 'outdoors');
INSERT INTO `plant_location` VALUES (68, 'outdoors');
INSERT INTO `plant_location` VALUES (69, 'outdoors');
INSERT INTO `plant_location` VALUES (70, 'outdoors');
INSERT INTO `plant_location` VALUES (71, 'outdoors');
INSERT INTO `plant_location` VALUES (72, 'outdoors');
INSERT INTO `plant_location` VALUES (73, 'outdoors');
INSERT INTO `plant_location` VALUES (74, 'outdoors');
INSERT INTO `plant_location` VALUES (75, 'indoors');
INSERT INTO `plant_location` VALUES (75, 'outdoors');
INSERT INTO `plant_location` VALUES (76, 'outdoors');
INSERT INTO `plant_location` VALUES (77, 'outdoors');
INSERT INTO `plant_location` VALUES (78, 'outdoors');
INSERT INTO `plant_location` VALUES (79, 'outdoors');
INSERT INTO `plant_location` VALUES (80, 'outdoors');
INSERT INTO `plant_location` VALUES (81, 'outdoors');
INSERT INTO `plant_location` VALUES (82, 'outdoors');
INSERT INTO `plant_location` VALUES (83, 'outdoors');
INSERT INTO `plant_location` VALUES (84, 'outdoors');
INSERT INTO `plant_location` VALUES (85, 'outdoors');
INSERT INTO `plant_location` VALUES (86, 'outdoors');
INSERT INTO `plant_location` VALUES (87, 'outdoors');
INSERT INTO `plant_location` VALUES (88, 'outdoors');
INSERT INTO `plant_location` VALUES (89, 'outdoors');
INSERT INTO `plant_location` VALUES (90, 'indoors');
INSERT INTO `plant_location` VALUES (90, 'outdoors');
INSERT INTO `plant_location` VALUES (91, 'outdoors');
INSERT INTO `plant_location` VALUES (92, 'outdoors');
INSERT INTO `plant_location` VALUES (93, 'outdoors');
INSERT INTO `plant_location` VALUES (94, 'outdoors');
INSERT INTO `plant_location` VALUES (95, 'indoors');
INSERT INTO `plant_location` VALUES (95, 'outdoors');
INSERT INTO `plant_location` VALUES (96, 'outdoors');
INSERT INTO `plant_location` VALUES (97, 'outdoors');
INSERT INTO `plant_location` VALUES (98, 'outdoors');
INSERT INTO `plant_location` VALUES (99, 'indoors');
INSERT INTO `plant_location` VALUES (99, 'outdoors');
INSERT INTO `plant_location` VALUES (100, 'outdoors');
INSERT INTO `plant_location` VALUES (101, 'outdoors');
INSERT INTO `plant_location` VALUES (102, 'outdoors');
INSERT INTO `plant_location` VALUES (103, 'outdoors');
INSERT INTO `plant_location` VALUES (104, 'outdoors');
INSERT INTO `plant_location` VALUES (105, 'outdoors');
INSERT INTO `plant_location` VALUES (106, 'outdoors');
INSERT INTO `plant_location` VALUES (107, 'outdoors');
INSERT INTO `plant_location` VALUES (108, 'outdoors');
INSERT INTO `plant_location` VALUES (109, 'outdoors');
INSERT INTO `plant_location` VALUES (110, 'outdoors');
INSERT INTO `plant_location` VALUES (111, 'indoors');
INSERT INTO `plant_location` VALUES (111, 'outdoors');
INSERT INTO `plant_location` VALUES (112, 'outdoors');
INSERT INTO `plant_location` VALUES (113, 'outdoors');
INSERT INTO `plant_location` VALUES (114, 'indoors');
INSERT INTO `plant_location` VALUES (114, 'outdoors');
INSERT INTO `plant_location` VALUES (115, 'outdoors');
INSERT INTO `plant_location` VALUES (116, 'indoors');
INSERT INTO `plant_location` VALUES (116, 'outdoors');
INSERT INTO `plant_location` VALUES (117, 'indoors');
INSERT INTO `plant_location` VALUES (117, 'outdoors');
INSERT INTO `plant_location` VALUES (118, 'outdoors');
INSERT INTO `plant_location` VALUES (119, 'indoors');
INSERT INTO `plant_location` VALUES (119, 'outdoors');
INSERT INTO `plant_location` VALUES (120, 'outdoors');
INSERT INTO `plant_location` VALUES (121, 'outdoors');
INSERT INTO `plant_location` VALUES (122, 'indoors');
INSERT INTO `plant_location` VALUES (123, 'outdoors');
INSERT INTO `plant_location` VALUES (124, 'outdoors');
INSERT INTO `plant_location` VALUES (125, 'outdoors');
INSERT INTO `plant_location` VALUES (126, 'outdoors');
INSERT INTO `plant_location` VALUES (127, 'outdoors');
INSERT INTO `plant_location` VALUES (128, 'outdoors');
INSERT INTO `plant_location` VALUES (129, 'outdoors');
INSERT INTO `plant_location` VALUES (130, 'outdoors');
INSERT INTO `plant_location` VALUES (131, 'outdoors');
INSERT INTO `plant_location` VALUES (132, 'outdoors');
INSERT INTO `plant_location` VALUES (133, 'indoors');
INSERT INTO `plant_location` VALUES (133, 'outdoors');
INSERT INTO `plant_location` VALUES (134, 'outdoors');
INSERT INTO `plant_location` VALUES (136, 'indoors');
INSERT INTO `plant_location` VALUES (136, 'outdoors');
INSERT INTO `plant_location` VALUES (137, 'indoors');
INSERT INTO `plant_location` VALUES (137, 'outdoors');
INSERT INTO `plant_location` VALUES (138, 'indoors');
INSERT INTO `plant_location` VALUES (138, 'outdoors');
INSERT INTO `plant_location` VALUES (139, 'outdoors');
INSERT INTO `plant_location` VALUES (145, 'indoors');
INSERT INTO `plant_location` VALUES (145, 'outdoors');
INSERT INTO `plant_location` VALUES (146, 'outdoors');
INSERT INTO `plant_location` VALUES (147, 'outdoors');
INSERT INTO `plant_location` VALUES (148, 'indoors');
INSERT INTO `plant_location` VALUES (148, 'outdoors');
INSERT INTO `plant_location` VALUES (149, 'outdoors');
INSERT INTO `plant_location` VALUES (155, 'indoors');
INSERT INTO `plant_location` VALUES (155, 'outdoors');
INSERT INTO `plant_location` VALUES (156, 'indoors');
INSERT INTO `plant_location` VALUES (156, 'outdoors');
INSERT INTO `plant_location` VALUES (157, 'indoors');
INSERT INTO `plant_location` VALUES (157, 'outdoors');
INSERT INTO `plant_location` VALUES (158, 'outdoors');
INSERT INTO `plant_location` VALUES (159, 'outdoors');
INSERT INTO `plant_location` VALUES (160, 'outdoors');
INSERT INTO `plant_location` VALUES (162, 'outdoors');
INSERT INTO `plant_location` VALUES (163, 'outdoors');
INSERT INTO `plant_location` VALUES (164, 'outdoors');
INSERT INTO `plant_location` VALUES (166, 'outdoors');
INSERT INTO `plant_location` VALUES (167, 'outdoors');
INSERT INTO `plant_location` VALUES (168, 'indoors');
INSERT INTO `plant_location` VALUES (168, 'outdoors');
INSERT INTO `plant_location` VALUES (169, 'indoors');
INSERT INTO `plant_location` VALUES (169, 'outdoors');
INSERT INTO `plant_location` VALUES (170, 'indoors');
INSERT INTO `plant_location` VALUES (170, 'outdoors');
INSERT INTO `plant_location` VALUES (171, 'indoors');
INSERT INTO `plant_location` VALUES (175, 'indoors');
INSERT INTO `plant_location` VALUES (175, 'outdoors');
INSERT INTO `plant_location` VALUES (176, 'indoors');
INSERT INTO `plant_location` VALUES (176, 'outdoors');
INSERT INTO `plant_location` VALUES (178, 'indoors');
INSERT INTO `plant_location` VALUES (178, 'outdoors');






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
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', 'e10adc3949ba59abbe56e057f20f883e', '0,6,7,2,1', 'MTIzMzIxMzEyMzEyMzRAcXEuY29t');
INSERT INTO `user` VALUES (2, '李四', 'f379eaf3c831b04de153469d1bec345e', '0', '');

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
