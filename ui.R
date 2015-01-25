shinyUI(
  pageWithSidebar(
    # Application Title
    headerPanel("Chicago 311 Pothole Repair Performance"),
    sidebarPanel(
      h4('How long should it take to repair a Chicago pothole reported via 311?'),
      h4('It depends.'),
      h4('Select your Neighborhood and hit Go:'),
      selectInput('cArea',
	'Give data a few seconds to load before you begin.',choices=
        (c(	'Albany Park'='14', 'Archer Heights'='57', 'Armour Square'='34',
		'Ashburn'='70', 'Auburn Gresham'='71', 'Austin'='25',
		'Avalon Park'='45', 'Avondale'='21', 'Belmont Cragin'='19',
		'Beverly'='72', 'Bridgeport'='60', 'Brighton Park'='58',
		'Burnside'='47', 'Calumet Heights'='48', 'Chatham'='44',
		'Chicago Lawn'='66', 'Clearing'='64', 'Douglas'='35',
		'Dunning'='17', 'East Garfield Park'='27', 'East Side'='52',
		'Edgewater'='77', 'Edison Park'='9', 'Englewood'='68',
		'Forest Glen'='12', 'Fuller Park'='37', 'Gage Park'='63',
		'Garfield Ridge'='56', 'Grand Boulevard'='38', 'Greater Grand Crossing'='69',
		'Hegewisch'='55', 'Hermosa'='20', 'Humboldt Park'='23',
		'Hyde Park'='41', 'Irving Park'='16', 'Jefferson Park'='11',
		'Kenwood'='39', 'Lake View'='6', 'Lincoln Park'='7',
		'Lincoln Square'='4', 'Logan Square'='22', 'Loop'='32',
		'Lower West Side'='31', 'McKinley Park'='59', 'Montclare'='18',
		'Morgan Park'='75', 'Mount Greenwood'='74', 'Near North Side'='8',
		'Near South Side'='33', 'New City'='61', 'North Center'='5',
		'North Lawndale'='29', 'North Park'='13', 'Norwood Park'='10',
		'Near West Side'='28', 'Oakland'='36', "O'Hare"='76',
		'Portage Park'='15', 'Pullman'='50', 'Riverdale'='54',
		'Rogers Park'='1', 'Roseland'='49', 'South Chicago'='46',
		'South Deering'='51', 'South Lawndale'='30', 'South Shore'='43',
		'Uptown'='3', 'Washington Heights'='73', 'Washington Park'='40',
		'West Elsdon'='62', 'West Englewood'='67', 'West Garfield Park'='26',
		'West Lawn'='65', 'West Pullman'='53', 'West Ridge'='2',
		'West Town'='24', 'Woodlawn'='42'
        ))),
      submitButton('Go'),
      br(),
      p('The Chicago Department of Transportation (CDOT) oversees the patching of potholes on over 4,000 miles of arterial and residential streets in Chicago. CDOT receives reports of potholes through the 311 call center and uses a computerized mapping and tracking system to identify pothole locations and efficiently schedule crews. One call to 311 can generate multiple pothole repairs. When a crew arrives to repair a 311 pothole, it fills all the other potholes within the block. Pothole repairs are generally completed within 7 days from the first report of a pothole to 311. Weather conditions, particularly frigid temps and precipitation, influence how long a repair takes. On days when weather is cooperative and there is no precipitation, crews can fill several thousand potholes.'),
      p('Data was extracted from the City of Chicago Data Portal, 311 Service Requests - Pot Holes Reported. For this study, only cases reported 2011-2014, and completed by 1/24/15 were used. Duplicates, cases with invalid Community Area numbers, and a small number of outliers (280 days or more) were removed from the dataset.'),
      p('https://data.cityofchicago.org/')
    ),
    mainPanel(
      h4(textOutput("cityMeanText")),
      h4(textOutput("cityMedianText")),
      h3(textOutput("panelHeader")),
      h4(textOutput("caCountText")),
      h4(textOutput("myMeanText")),
      p(textOutput("verdictMean")),
      h4(textOutput("myMedianText")),
      p(textOutput("verdictMedian")),
      plotOutput("plot")
    )
  )
)
