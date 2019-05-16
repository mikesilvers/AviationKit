//
//  TafParser.swift
//  AviationKit
//
//  Created by Mike Silvers on 5/7/19.
//

import Foundation

public class TafParser : NSObject, XMLParserDelegate {
    
    public var demoTAF : String {
        get {
            var st = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            st.append("<response xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XML-Schema-instance\" version=\"1.2\" ")
            st.append("xsi:noNamespaceSchemaLocation=\"http://aviationweather.gov/adds/schema/taf1_2.xsd\"> ")
            st.append("     <request_index>41615385</request_index> ")
            st.append("     <data_source name=\"tafs\" /> ")
            st.append("     <request type=\"retrieve\" /> ")
            st.append("     <errors /> ")
            st.append("     <warnings /> ")
            st.append("     <time_taken_ms>2403</time_taken_ms> ")
            st.append("     <data num_results=\"2828\"> ")
            
            st.append("         <TAF>" )
            st.append("             <raw_text>KENW 061606Z 0616/0712 02010G18KT P6SM -SHRA OVC025 FM061700 02010KT P6SM OVC020 FM062100 03010KT P6SM BKN040 FM070400 02007KT P6SM VCSH OVC045</raw_text>" )
            st.append("             <station_id>KENW</station_id>" )
            st.append("             <issue_time>2019-05-06T16:06:00Z</issue_time>" )
            st.append("             <bulletin_time>2019-05-06T16:06:00Z</bulletin_time>" )
            st.append("             <valid_time_from>2019-05-06T16:00:00Z</valid_time_from>" )
            st.append("             <valid_time_to>2019-05-07T12:00:00Z</valid_time_to>" )
            st.append("             <remarks>AMD</remarks>" )
            st.append("             <latitude>42.6</latitude>" )
            st.append("             <longitude>-87.93</longitude>" )
            st.append("             <elevation_m>219.0</elevation_m>" )
            st.append("             <forecast>" )
            st.append("                 <fcst_time_from>2019-05-06T16:00:00Z</fcst_time_from>" )
            st.append("                 <fcst_time_to>2019-05-06T17:00:00Z</fcst_time_to>" )
            st.append("                 <wind_dir_degrees>20</wind_dir_degrees>" )
            st.append("                 <wind_speed_kt>10</wind_speed_kt>" )
            st.append("                 <wind_gust_kt>18</wind_gust_kt>" )
            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
            st.append("                 <wx_string>-SHRA</wx_string>" )
            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"2500\" />" )
            st.append("             </forecast>" )
            st.append("             <forecast>" )
            st.append("                 <fcst_time_from>2019-05-06T17:00:00Z</fcst_time_from>" )
            st.append("                 <fcst_time_to>2019-05-06T21:00:00Z</fcst_time_to>" )
            st.append("                 <change_indicator>FM</change_indicator>" )
            st.append("                 <wind_dir_degrees>20</wind_dir_degrees>" )
            st.append("                 <wind_speed_kt>10</wind_speed_kt>" )
            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"2000\" />" )
            st.append("             </forecast>" )
            st.append("             <forecast>" )
            st.append("                 <fcst_time_from>2019-05-06T21:00:00Z</fcst_time_from>" )
            st.append("                 <fcst_time_to>2019-05-07T04:00:00Z</fcst_time_to>" )
            st.append("                 <change_indicator>FM</change_indicator>" )
            st.append("                 <wind_dir_degrees>30</wind_dir_degrees>" )
            st.append("                 <wind_speed_kt>10</wind_speed_kt>" )
            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"4000\" />" )
            st.append("             </forecast>" )
            st.append("             <forecast>" )
            st.append("                 <fcst_time_from>2019-05-07T04:00:00Z</fcst_time_from>" )
            st.append("                 <fcst_time_to>2019-05-07T12:00:00Z</fcst_time_to>" )
            st.append("                 <change_indicator>FM</change_indicator>" )
            st.append("                 <wind_dir_degrees>20</wind_dir_degrees>" )
            st.append("                 <wind_speed_kt>7</wind_speed_kt>" )
            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
            st.append("                 <wx_string>VCSH</wx_string>" )
            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"4500\" />" )
            st.append("             </forecast>" )
            st.append("         </TAF>" )

//            st.append("         <TAF>" )
//            st.append("             <raw_text>TAF AMD KBKF 061425Z 0614/0715 06009KT 9999 SCT007 BKN012 QNH2992INS TEMPO 0614/0616 SCT012 BECMG 0615/0616 22009KT 9999 SCT012 SCT100 QNH2993INS BECMG 0618/0619 34009KT 9999 VCTS FEW050CB SCT100 QNH2997INS BECMG 0621/0622 VRB12G18KT 9000 -TSRA SCT080CB BKN100 QNH2997INS TEMPO 0622/0702 VRB25G35KT 530005 BECMG 0702/0703 05009KT 9999 NSW BKN010 QNH3000INS BECMG 0710/0711 09009KT 4800 -SHRA BR VCTS BKN005 OVC010CB QNH3005INS TX16/0622Z TN09/0614Z</raw_text>" )
//            st.append("             <station_id>KBKF</station_id>" )
//            st.append("             <issue_time>2019-05-06T14:25:00Z</issue_time>" )
//            st.append("             <bulletin_time>2019-05-06T14:29:00Z</bulletin_time>" )
//            st.append("             <valid_time_from>2019-05-06T14:00:00Z</valid_time_from>" )
//            st.append("             <valid_time_to>2019-05-07T15:00:00Z</valid_time_to>" )
//            st.append("             <latitude>39.72</latitude>" )
//            st.append("             <longitude>-104.75</longitude>" )
//            st.append("             <elevation_m>1726.0</elevation_m>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T14:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T15:00:00Z</fcst_time_to>" )
//            st.append("                 <wind_dir_degrees>60</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>9</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>29.91142</altim_in_hg>" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"700\" />" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"1200\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T14:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T16:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>TEMPO</change_indicator>" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1200\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T15:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T18:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-06T16:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>220</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>9</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>29.94094</altim_in_hg>" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1200\" />" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"10000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T18:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T21:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-06T19:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>340</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>9</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>29.97047</altim_in_hg>" )
//            st.append("                 <wx_string>VCTS</wx_string>" )
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"5000\" cloud_type=\"CB\" />" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"10000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T21:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-07T02:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-06T22:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>0</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>12</wind_speed_kt>" )
//            st.append("                 <wind_gust_kt>18</wind_gust_kt>" )
//            st.append("                 <visibility_statute_mi>5.59</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>29.97047</altim_in_hg>" )
//            st.append("                 <wx_string>-TSRA</wx_string>" )
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"8000\" cloud_type=\"CB\" />" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"10000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T22:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-07T02:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>TEMPO</change_indicator>" )
//            st.append("                 <wind_dir_degrees>0</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>25</wind_speed_kt>" )
//            st.append("                 <wind_gust_kt>35</wind_gust_kt>" )
//            st.append("                 <turbulence_condition turbulence_intensity=\"3\" turbulence_max_alt_ft_agl=\"5000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-07T02:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-07T10:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-07T03:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>50</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>9</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>30.0</altim_in_hg>" )
//            st.append("                 <wx_string>NSW</wx_string>" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"1000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-07T10:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-07T15:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-07T11:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>90</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>9</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>2.98</visibility_statute_mi>" )
//            st.append("                 <altim_in_hg>30.05906</altim_in_hg>" )
//            st.append("                 <wx_string>-SHRA BR VCTS</wx_string>" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"500\" />" )
//            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"1000\" cloud_type=\"CB\" />" )
//            st.append("             </forecast>" )
//            st.append("         </TAF>" )

//            st.append("         <TAF>" )
//            st.append("             <raw_text>TAF MTPP 052231Z 0600/0624 11018KT 9999 FEW028 BKN250 TEMPO 0602/0606 10008KT BECMG 0608/0610 VRB02KT FM061200 12005KT 8000 FEW020 SCT070 BECMG 0614/0618 10015KT</raw_text>" )
//            st.append("             <station_id>MTPP</station_id>" )
//            st.append("             <issue_time>2019-05-05T22:31:00Z</issue_time>" )
//            st.append("             <bulletin_time>2019-05-05T00:00:00Z</bulletin_time>" )
//            st.append("             <valid_time_from>2019-05-06T00:00:00Z</valid_time_from>" )
//            st.append("             <valid_time_to>2019-05-07T00:00:00Z</valid_time_to>" )
//            st.append("             <latitude>18.57</latitude>" )
//            st.append("             <longitude>-72.28</longitude>" )
//            st.append("             <elevation_m>37.0</elevation_m>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T00:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T08:00:00Z</fcst_time_to>" )
//            st.append("                 <wind_dir_degrees>110</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>18</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2800\" />" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"25000\" />" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T02:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T06:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>TEMPO</change_indicator>" )
//            st.append("                 <wind_dir_degrees>100</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>8</wind_speed_kt>" )
//            st.append("             </forecast>" )
//            st.append("             <forecast>" )
//            st.append("                 <fcst_time_from>2019-05-06T08:00:00Z</fcst_time_from>" )
//            st.append("                 <fcst_time_to>2019-05-06T12:00:00Z</fcst_time_to>" )
//            st.append("                 <change_indicator>BECMG</change_indicator>" )
//            st.append("                 <time_becoming>2019-05-06T10:00:00Z</time_becoming>" )
//            st.append("                 <wind_dir_degrees>0</wind_dir_degrees>" )
//            st.append("                 <wind_speed_kt>2</wind_speed_kt>" )
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi>" )
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2800\" />" )
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"25000\" />" )
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-06T12:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T14:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>FM</change_indicator> ")
//            st.append("                 <wind_dir_degrees>120</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>5</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>4.97</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2000\" /> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"7000\" /> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-06T14:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-07T00:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>BECMG</change_indicator> ")
//            st.append("                 <time_becoming>2019-05-06T18:00:00Z</time_becoming> ")
//            st.append("                 <wind_dir_degrees>100</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>15</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>4.97</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2000\" /> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"7000\" /> ")
//            st.append("             </forecast> ")
//            st.append("         </TAF> ")
            
//            st.append("         <TAF> ")
//            st.append("             <raw_text>TAF AGGK 051730Z 0518/0618 11015KT 9999 -SHRA SCT016 OVC100 TEMPO 0518/0602 2000 RA SCT007 SCT015 OVC027</raw_text> ")
//            st.append("             <station_id>AGGK</station_id> ")
//            st.append("             <issue_time>2019-05-05T17:30:00Z</issue_time> ")
//            st.append("             <bulletin_time>2019-05-05T17:30:00Z</bulletin_time> ")
//            st.append("             <valid_time_from>2019-05-05T18:00:00Z</valid_time_from> ")
//            st.append("             <valid_time_to>2019-05-06T18:00:00Z</valid_time_to> ")
//            st.append("             <latitude>-10.45</latitude> ")
//            st.append("             <longitude>161.9</longitude> ")
//            st.append("             <elevation_m>23.0</elevation_m> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T18:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T02:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>TEMPO</change_indicator> ")
//            st.append("                 <visibility_statute_mi>1.24</visibility_statute_mi> ")
//            st.append("                 <wx_string>RA</wx_string> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"700\" /> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1500\" /> ")
//            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"2700\" /> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T18:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T18:00:00Z</fcst_time_to> ")
//            st.append("                 <wind_dir_degrees>110</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>15</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi> ")
//            st.append("                 <wx_string>-SHRA</wx_string> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1600\" /> ")
//            st.append("                 <sky_condition sky_cover=\"OVC\" cloud_base_ft_agl=\"10000\" /> ")
//            st.append("             </forecast> ")
//            st.append("         </TAF> ")

//            st.append("         <TAF> ")
//            st.append("             <raw_text>TAF SVBM 051600Z 0518/0618 09007KT 9999 BKN016 TX33/0518Z TN23/0608Z BECMG 0521/0601 07006KT 8000 RA SCT013 BKN060</raw_text> ")
//            st.append("             <station_id>SVBM</station_id> ")
//            st.append("             <issue_time>2019-05-05T16:00:00Z</issue_time> ")
//            st.append("             <bulletin_time>2019-05-05T18:00:00Z</bulletin_time> ")
//            st.append("             <valid_time_from>2019-05-05T18:00:00Z</valid_time_from> ")
//            st.append("             <valid_time_to>2019-05-06T18:00:00Z</valid_time_to> ")
//            st.append("             <latitude>10.05</latitude> ")
//            st.append("             <longitude>-69.37</longitude> ")
//            st.append("             <elevation_m>614.0</elevation_m> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T18:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-05T21:00:00Z</fcst_time_to> ")
//            st.append("                 <wind_dir_degrees>90</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>7</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>6.21</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"1600\" /> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T21:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T18:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>BECMG</change_indicator> ")
//            st.append("                 <time_becoming>2019-05-06T01:00:00Z</time_becoming> ")
//            st.append("                 <wind_dir_degrees>70</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>6</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>4.97</visibility_statute_mi> ")
//            st.append("                 <wx_string>RA</wx_string> ")
//            st.append("                 <not_decoded>TX33/0518Z TN23/0608Z</not_decoded> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1300\" /> ")
//            st.append("                 <sky_condition sky_cover=\"BKN\" cloud_base_ft_agl=\"6000\" /> ")
//            st.append("             </forecast> ")
//            st.append("         </TAF> ")
            
//            st.append("         <TAF> ")
//            st.append("             <raw_text>TAF FZNA 051100Z 0512/0618 21008KT 9000 SCT018 FEW022CB PROB30 TEMPO 0512/0516 6000 -TSRA BECMG 0521/0523 SCT014 BECMG 0608/0610 FEW019 FEW023CB</raw_text> ")
//            st.append("             <station_id>FZNA</station_id> ")
//            st.append("             <issue_time>2019-05-05T11:00:00Z</issue_time> ")
//            st.append("             <bulletin_time>2019-05-05T10:00:00Z</bulletin_time> ")
//            st.append("             <valid_time_from>2019-05-05T12:00:00Z</valid_time_from> ")
//            st.append("             <valid_time_to>2019-05-06T18:00:00Z</valid_time_to> ")
//            st.append("             <latitude>-1.67</latitude> ")
//            st.append("             <longitude>29.22</longitude> ")
//            st.append("             <elevation_m>1552.0</elevation_m> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T12:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-05T21:00:00Z</fcst_time_to> ")
//            st.append("                 <wind_dir_degrees>210</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>8</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>5.59</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1800\" /> ")
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2200\" cloud_type=\"CB\" /> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T12:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-05T16:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>TEMPO</change_indicator> ")
//            st.append("                 <probability>30</probability> ")
//            st.append("                 <visibility_statute_mi>3.73</visibility_statute_mi> ")
//            st.append("                 <wx_string>-TSRA</wx_string> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-05T21:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T08:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>BECMG</change_indicator> ")
//            st.append("                 <time_becoming>2019-05-05T23:00:00Z</time_becoming> ")
//            st.append("                 <wind_dir_degrees>210</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>8</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>5.59</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"SCT\" cloud_base_ft_agl=\"1400\" /> ")
//            st.append("             </forecast> ")
//            st.append("             <forecast> ")
//            st.append("                 <fcst_time_from>2019-05-06T08:00:00Z</fcst_time_from> ")
//            st.append("                 <fcst_time_to>2019-05-06T18:00:00Z</fcst_time_to> ")
//            st.append("                 <change_indicator>BECMG</change_indicator> ")
//            st.append("                 <time_becoming>2019-05-06T10:00:00Z</time_becoming> ")
//            st.append("                 <wind_dir_degrees>210</wind_dir_degrees> ")
//            st.append("                 <wind_speed_kt>8</wind_speed_kt> ")
//            st.append("                 <visibility_statute_mi>5.59</visibility_statute_mi> ")
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"1900\" /> ")
//            st.append("                 <sky_condition sky_cover=\"FEW\" cloud_base_ft_agl=\"2300\" cloud_type=\"CB\" /> ")
//            st.append("             </forecast> ")
//            st.append("         </TAF> ")

            st.append("     </data> ")
            st.append(" </response> ")

            return st
        }
    }
    //MARK: Supporting variables
    private var tafs : [TAF]       = []
    private var currentTaf         = TAF()
    private var currentForecast    = Forecast()
    private var currentTemperature = Temperature()

    private var parser : XMLParser = XMLParser()
    private var currentElement = ""
    
    private var currentValues = current()
    
    private var dateformatter = DateFormatter()
    
    //MARK: Supporting structures
    /// This private struct contains the current values parsed from XML
    private struct current {
        
        var bool    = false
        var double  = 0.0
        var string  = ""
        var integer = 0
        
        var forecast            = Forecast()
        var temperature         = Temperature()
        var skycondition        = SkyCondition()
        var icingcondition      = IcingCondition()
        var turbulencecondition = TurbulenceCondition()
        
    }

    //MARK: Initializers
    
    /**
     Initializes the new *MafParser*.
     
     - Returns: A new instance of the MafParser.
     
     */
    public override init() {
        // configure the date formatter for conversion between epoch time and the
        // time passed in ISO8601 UTC format
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
    }

    //MARK: Core functions
    /**
     The completion block for the return of parsed TAF objects.
     
     - parameter metar: An array of TAF objects parsed from the XML documents
     */
    public typealias parseCompletion = (_ taf: [TAF])->()

    /**
     This function will parse the XML document and return an array of TAF obects.
     
     - parameter data: *Data* representation of the XML document
     - parameter completion: The completion block that returns the TAF array
     
     */
    public func parseDocument(_ data: Data, completion: parseCompletion) {
        
        // we are setting the XMLParser and the delegate to this class
        parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            // return the array of METAR objects
            completion(self.tafs)
        } else if let  pe = parser.parserError {
            print("Parse Error (PE1000): \(pe)")
        }
        
    }
    
    //MARK: XMLParserDelegate functions
    public func parserDidStartDocument(_ parser: XMLParser) {
        // we are only setting this for debug purposes - so you can see when the document has started processing
        print("parserDidStartDocument")
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        // we are only setting this for debug purposes - so you can see when the document has ended processing
        print("parserDidEndDocument")
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = ""
        
        // process dependent upon the current element
        switch elementName {
        case "TAF":
            // note: no currentElement because this is the outermost element
            // reset the current TAF object.  We build this object as the XML is processed
            currentTaf = TAF()

        case "forecast":
            // reset the current Forecast object.  We build this object as the XML is processed
            currentElement = elementName
            currentForecast = Forecast()

        case "temperature":
            // reset the current Forecast object.  We build this object as the XML is processed
            currentElement     = elementName
            currentTemperature = Temperature()
            
        case "sky_condition":
            // create a new SkyConditions object for processing
            currentElement = elementName
            var sky = SkyCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["sky_cover"] {
                sky.skyCover = skc
            }
            
            if let skc = attributeDict["cloud_base_ft_agl"], let skcI = Int(skc) {
                sky.cloudBase = skcI
            }
            
            if let skc = attributeDict["cloud_type"] {
                sky.cloudType = skc
            }
            
            // set the new sky condition object to the current TAF
            currentValues.skycondition = sky
            
        case "turbulence_condition":
            // create a new TurbulenceCondition object for processing
            currentElement = elementName
            var sky = TurbulenceCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["turbulence_intensity"] {
                sky.intensity = skc
            }
            
            if let skc = attributeDict["turbulence_min_alt_ft_agl"], let skcI = Int(skc) {
                sky.minAltitude = skcI
            }
            
            if let skc = attributeDict["turbulence_max_alt_ft_agl"], let skcI = Int(skc) {
                sky.maxAltitude = skcI
            }

            // set the new turbulence condition object to the current TAF
            currentValues.turbulencecondition = sky
        
        case "icing_condition":
            // create a new IcingConditions object for processing
            currentElement = elementName
            var sky = IcingCondition()
            
            // the attributes of the sky conditions are all element attributes, there is
            // no data to this element - so all of the processing is done right here
            if let skc = attributeDict["icing_intensity"] {
                sky.intensity = skc
            }
            
            if let skc = attributeDict["icing_min_alt_ft_agl"], let skcI = Int(skc) {
                sky.minAltitude = skcI
            }
            
            if let skc = attributeDict["icing_max_alt_ft_agl"], let skcI = Int(skc) {
                sky.maxAltitude = skcI
            }
            
            // set the new icing condition object to the current TAF
            currentValues.icingcondition = sky

        default:
            // all other elements are processed, so set the current element name
            currentElement = elementName
        }

    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "TAF":
            // when the TAF element is ended, add the TAF we created to the array that will be returned later
            tafs.append(currentTaf)
            
        case "forecast":
            // when the forecast element is ended, add the forecast we created to the current TAF
            if currentTaf.forecast == nil {
                currentTaf.forecast = [currentForecast]
            } else {
                currentTaf.forecast?.append(currentForecast)
            }

        case "sky_condition":
            // there may be multiple sky conditions - so this is an array of sky conditions
            if currentForecast.skyCondition == nil {
                currentForecast.skyCondition = [currentValues.skycondition]
            } else {
                currentForecast.skyCondition?.append(currentValues.skycondition)
            }

        case "turbulence_condition":
            // there may be multiple turbulence conditions - so this is an array of sky conditions
            if currentForecast.turbulenceCondition == nil {
                currentForecast.turbulenceCondition = [currentValues.turbulencecondition]
            } else {
                currentForecast.turbulenceCondition?.append(currentValues.turbulencecondition)
            }

        case "icing_condition":
            // there may be multiple icing conditions - so this is an array of sky conditions
            if currentForecast.icingCondition == nil {
                currentForecast.icingCondition = [currentValues.icingcondition]
            } else {
                currentForecast.icingCondition?.append(currentValues.icingcondition)
            }

        case "temperature":
            // there may be multiple temperature conditions - so this is an array of sky conditions
            if currentForecast.temperature == nil {
                currentForecast.temperature = [currentValues.temperature]
            } else {
                currentForecast.temperature?.append(currentValues.temperature)
            }

            
        case "raw_text":
            // this is the actual raw text of the METAR
            currentTaf.rawText = currentValues.string
        case "station_id":
            // the station ID for the weather station
            currentTaf.stationId = currentValues.string
        case "issue_time":
            // the time the observation was made (in Epoch)
            currentTaf.issueTime = currentValues.integer
        case "bulletin_time":
            // the time the observation was made (in Epoch)
            currentTaf.bulletinTime = currentValues.integer
        case "valid_time_from":
            // the time the TAF starts (in Epoch)
            currentTaf.fromTime = currentValues.integer
        case "valid_time_to":
            // the time the TAF ends (in Epoch)
            currentTaf.toTime = currentValues.integer
        case "latitude":
            // latitude of the weather station
            currentTaf.latitude = currentValues.double
        case "longitude":
            // longitude of the weather station
            currentTaf.longitude = currentValues.double
        case "remarks":
            // remarks for the TAF
            currentTaf.remarks = currentValues.string
        case "elevation_m":
            // the elevation of the weather station in meters
            currentTaf.elevation = currentValues.double

        case "fcst_time_from":
            // the current time from for forecast
            currentForecast.validFromTime = currentValues.integer
        case "fcst_time_to":
            // the current time from to forecast
            currentForecast.validToTime = currentValues.integer
        case "change_indicator":
            // the current change
            currentForecast.changeIndicator = currentValues.string
        case "time_becoming":
            // the current time starting
            currentForecast.timeBecoming = currentValues.integer
        case "probability":
            // the probability for the forecast
            currentForecast.probability = currentValues.integer
        case "wind_dir_degrees":
            currentForecast.windDirection = currentValues.integer
        case "wind_speed_kt":
            currentForecast.windSpeed = currentValues.integer
        case "wind_gust_kt":
            currentForecast.windGust = currentValues.integer
        case "wind_shear_hgt_ft_agl":
            currentForecast.windShearHeightAGL = currentValues.integer
        case "wind_shear_dir_degrees":
            currentForecast.windShearDirection = currentValues.integer
        case "wind_shear_speed_kt":
            currentForecast.windShearSpeed = currentValues.integer
        case "visibility_statute_mi":
            currentForecast.visibility = currentValues.double
        case "altim_in_hg":
            currentForecast.altimiter = currentValues.double
        case "vert_vis_ft":
            currentForecast.verticalVisibility = currentValues.integer
        case "wx_string":
            currentForecast.weatherDescription = currentValues.string
        case "not_decoded":
            currentForecast.notDecoded = currentValues.string
            
        case "valid_time":
            currentTemperature.validTime = currentValues.integer
        case "sfc_temp_c":
            currentTemperature.surfaceTemp = currentValues.double
        case "max_temp_c":
            currentTemperature.maxTemp = currentValues.double
        case "min_temp_c":
            currentTemperature.minTemp = currentValues.double

            
        default:
            // this is the default "whoops - we missed that one"
            print("Element \(elementName) NOT ended")
        }
        
        // after we have processed the record, reset the current stuff
        currentElement = ""
        currentValues = current()
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // set the base data and make sure there are no spaces or anything
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            
            // process the correct data type according to the current element we are using
            switch currentElement {
                
            case "valid_time",
                 "issue_time",
                 "fcst_time_to",
                 "bulletin_time",
                 "valid_time_to",
                 "time_becoming",
                 "fcst_time_from",
                 "valid_time_from":
                // format the date/time to Epoch
                if let di = dateformatter.date(from: data) {
                    let dii = di.timeIntervalSince1970
                    currentValues.integer = Int(dii)
                }
                
            // the integer elements
            case "vert_vis_ft",
                 "probability",
                 "wind_gust_kt",
                 "wind_speed_kt",
                 "wind_dir_degrees",
                 "wind_shear_speed_kt",
                 "wind_shear_hgt_ft_agl",
                 "wind_shear_dir_degrees":
                currentValues.integer = Int(data) ?? 0
                
            // the double elements
            case "latitude",
                 "longitude",
                 "sfc_temp_c",
                 "min_temp_c",
                 "max_temp_c",
                 "elevation_m",
                 "altim_in_hg",
                 "visibility_statute_mi":
                currentValues.double = Double(data) ?? 0.0
                
            // the text elements
            case "remarks",
                 "raw_text",
                 "wx_string",
                 "station_id",
                 "not_decoded",
                 "change_indicator":
                currentValues.string.append(data)
                
            default:
                // the current element was not found int he list - this is a debug statement
                print("The element \(currentElement) was NOT found for foundCharacters  The data is: \(data)")
            }
        }
    }

    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        // this is just a debug statement for a parser error
        print("Parse error thrown: \(parseError)")
    }



}
