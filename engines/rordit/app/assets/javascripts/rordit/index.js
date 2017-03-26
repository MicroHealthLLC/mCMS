var myMixin = {
    data: {
        links: [],
        page: 0,
        pageType: { popular: true, newest: false, search: false },
        searchParam: "",
        previous: false,
        next: true,
        pageCount: 0
    },
    created: function () {
        this.getPopularLinks(this.page);
    },
    methods: {
        getPopularLinks: function () {
            this.changePageType("popular");
            this.$http.get('/rordit/get-popular-links/' + this.page).then(function (response) {
                this.links = response["body"]["links"];
                this.pageCount = response["body"]["page_count"];
                if(this.pageCount == 0){
                    this.next = false;
                }
            });
        },
        getNewestLinks: function () {
            this.changePageType("newest");
            this.$http.get('/rordit/get-newest-links/' + this.page).then(function (response) {
                this.links = response["body"]["links"];
                this.pageCount = response["body"]["page_count"];
                if(this.pageCount == 0){
                    this.next = false;
                }
            });
        },
        getSearchResults:function () {
            this.changePageType("search");
            this.$http.post('/rordit/get-search-results/' + this.page, {
                search: this.searchParam
            }).then(function (response) {
                this.links = response["body"]["links"];
                this.pageCount = response["body"]["page_count"];
                if(this.pageCount == 0){
                    this.next = false;
                }
            });
        },
        nextPage: function () {
            this.page = this.page + 1;
            if(this.pageCount == this.page){
                this.next = false;
            }
            if(this.page > 0){
                this.previous = true;
            }

            if(this.pageType["popular"]){
                this.getPopularLinks();
            }else if(this.pageType["newest"]){
                this.getNewestLinks()
            }else {
                this.getSearchResults();
            }
        },
        previousPage: function(){
            this.page = this.page - 1;
            if(this.pageCount > this.page){
                this.next = true;
            }
            if(this.page == 0){
                this.previous = false;
            }
            if(this.pageType["popular"]){
                this.getPopularLinks();
            }else if(this.pageType["newest"]){
                this.getNewestLinks()
            }else {
                this.getSearchResults();
            }
        },
        givePointToLink: function (id, index) {
            this.$http.get('/rordit/link/' + id + '/give-point').then(function(response){
                this.links[index]["points_count"] = response["body"]["totalPoint"];
            }, function (response) {
                if(response["status"] == 401){
                    window.location = "/login";
                }else {
                    this.showModal(response["body"]["message"]);
                }
            });
        },
        changePageType: function (type) {
            if(type != this.getCurrentPageType()){
                for(currentType in this.pageType){
                    if(currentType == type){
                        this.pageType[type] = true;
                    }else{
                        this.pageType[currentType] = false;
                    }
                }
                this.page = 0;
            }

        },
        getCurrentPageType: function () {
            for(type in this.pageType){
                if(this.pageType[type] == true){
                    return type
                }
            }
        }
    }
};