$.ajaxSetup({
    headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
});
function Kanban(a, b) {
    return {
        id: '',
        name: a,
        numberOfColumns: b,
        columns: [],
        archived: [],
        settings: {}
    }
}
function Kanban(a, b,id) {
    return {
        id: id,
        name: a,
        numberOfColumns: b,
        columns: [],
        archived: [],
        settings: {}
    }
}

function KanbanColumn(a) {
    return {
        id: '',
        name: a,
        cards: [],
        settings: {}
    }
}

function KanbanColumn(a, b) {
    return {
        id: '',
        name: a,
        cards: [],
        settings: b
    }
}
function KanbanColumn(a, b, id) {
    return {
        id: id,
        name: a,
        cards: [],
        settings: b
    }
}

function KanbanCard(a, b, c) {
    return this.name = a, this.details = b, this.color = c, this
}

function KanbanCard(a, b, c, i) {
    return this.id = i, this.name = a, this.details = b, this.color = c, this
}

var mpkModule = angular.module("mpk", ["ngSanitize", "ngRoute", "angularSpectrumColorpicker"]);
mpkModule.config(["$routeProvider", "$locationProvider", function(a) {
    a.when("/kanban", {
        templateUrl: "kanban.html",
        controller: "ApplicationController"
    }).when("/kanban/:kanbanName", {
        templateUrl: "kanban.html",
        controller: "ApplicationController"
    }).otherwise({
        redirectTo: "/kanban"
    })
}]), angular.module("mpk").factory("kanbanRepository", ["cryptoService", function(a, b) {
    return {
        kanbansByName: {},
        lastUsed: "",
        theme: "default-bright",
        lastUpdated: 0,
        add: function(a) {
            return this.kanbansByName[a.name] = a, this.save(), a
        },
        all: function() {
            return this.kanbansByName
        },
        get: function(a) {
            return this.kanbansByName[a]
        },
        remove: function(a) {
            return this.kanbansByName[a] && delete this.kanbansByName[a], this.kanbansByName
        },
        prepareSerializedKanbans: function() {
            var a = {
                kanbans: this.kanbansByName,
                lastUsed: this.lastUsed,
                theme: this.theme,
                lastUpdated: this.lastUpdated
            };
            return angular.toJson(a, !1)
        },
        save: function() {
            var a = this.prepareSerializedKanbans();
            ////$.ajax({url: '/service/save.json', data: {data: a}})
            //return localStorage.setItem("myPersonalKanban", a), this.kanbansByName
        },
        resave: function(){

        },
        load: function() {
            var a = angular.fromJson(localStorage.getItem("myPersonalKanban"));
            return null === a ? null : (this.kanbansByName = a.kanbans, this.lastUsed = a.lastUsed, this.theme = a.theme, this.lastUpdated = a.lastUpdated, this.kanbansByName)
        },
        getLastUsed: function() {
            return this.lastUsed ? this.kanbansByName[this.lastUsed] : this.kanbansByName[Object.keys(this.kanbansByName)[0]]
        },
        setLastUsed: function(a) {
            return this.lastUsed = a, this.lastUsed
        },
        getTheme: function() {
            return this.theme
        },
        setTheme: function(a) {
            return this.theme = a, this.theme
        },
        upload: function() {
            return a.uploadKanban(this.prepareSerializedKanbans())
        },
        setLastUpdated: function(a) {
            return this.lastUpdated = a, this
        },
        getLastUpdated: function() {
            return this.lastUpdated
        },
        download: function() {
            return a.downloadKanban()
        },
        saveDownloadedKanban: function(c, d) {
            if ("string" == typeof c) try {
                c = b.decrypt(c, a.settings.encryptionKey)
            } catch (e) {
                return console.debug(e), {
                    success: !1,
                    message: "Looks like Kanban saved in the cloud was persisted with different encryption key. You'll need to use old key to download your Kanban. Set it up in the Cloud Setup menu."
                }
            }
            var f = angular.fromJson(c);
            return this.kanbansByName = f.kanbans, this.lastUsed = f.lastUsed, this.theme = f.theme, this.lastUpdated = d,{
                success: !0
            }
        },
        renameLastUsedTo: function(a) {
            var b = this.getLastUsed();
            return delete this.kanbansByName[b.name], b.name = a, this.kanbansByName[a] = b, this.lastUsed = a, !0
        },
        "import": function(a) {
            var b = this;
            angular.forEach(Object.keys(a), function(c) {
                b.kanbansByName[c] = a[c]
            });
            var c = Object.keys(a);
            this.setLastUsed(a[c[0]]), this.save()
        }
    }
}]), angular.module("mpk").factory("kanbanManipulator", function() {
    return {
        columnIndex: function(a, b) {
            var c;
            return angular.forEach(a.columns, function(a, d) {
                a === b && (c = d)
            }), c
        },
        addColumn: function(a, b) {
            a.columns.push(new KanbanColumn(b))
        },
        addCardToColumn: function(a, b, c, d, e, id) {
            angular.forEach(a.columns, function(a) {
                a.name === b.name && a.cards.push(new KanbanCard(c, d, e, id))
            })
        },
        removeCardFromColumn: function(a, b, c) {
            angular.forEach(a.columns, function(a) {
                a.name === b.name && a.cards.splice(a.cards.indexOf(c), 1)
            })
        },
        archiveCard: function(a, b, c) {
            that = this
            data = {
                column: b.name,
                column_id: b.id,
                project: a.name,
                project_id: a.id,
                card_id:  c.id
            }
            $.ajax({
                url: '/kanban/cards/archive.json',
                type: 'POST',
                data: data,
                async: false,
                success: function(json){
                    if(json['success']){
                        void 0 == a.archived && (a.archived = []);
                        a.archived.push({
                            card: c,
                            archivedOn: new Date
                        });
                        that.removeCardFromColumn(a, b, c)
                    }
                    else
                        alert(json['errors'])
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                }
            })
        },
        unarchiveCard: function(a, b) {
            data = {
                project: a.name,
                project_id: a.id,
                card_id:  b.card.id
            }
            $.ajax({
                url: '/kanban/cards/unarchive.json',
                type: 'POST',
                data: data,
                async: false,
                success: function(json){
                    if(json['success']){
                        function c(a) {
                            return a.columns[a.columns.length - 1]
                        }
                        that.removeFromArchive(a, b);
                        c(a).cards.push(b.card)
                    }
                    else
                        alert(json['errors'])
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                }
            })
        },
        removeFromArchive: function(a, b) {
            a.archived.splice(a.archived.indexOf(b), 1)
        },
        createNewFromTemplate: function(a, b) {
            var c = new Kanban(b, a.columns.length);
            return angular.forEach(a.columns, function(a) {
                c.columns.push(new KanbanColumn(a.name, a.settings))
            }), c
        },
        removeColumn: function(a, b) {
            var c = this.columnIndex(a, b);
            return a.columns.splice(c, 1), a.numberOfColumns--, a
        },
        addColumnNextToColumn: function(a, b, c, k) {
            var d = this.columnIndex(a, b);
            return "left" == c ? a.columns.splice(d, 0, k) : a.columns.splice(d + 1, 0, k), a.numberOfColumns++, a
        }
    }
}), angular.module("mpk").factory("themesProvider", ["$window", function(a) {
    var b = a.themes;
    return {
        getThemes: function() {
            return b
        },
        setCurrentTheme: function(a) {
            //var b = document.getElementById("themeStylesheet"),
            //    c = b.href.substr(0, b.href.lastIndexOf("/"));
            //return b.href = c + "/" + a + ".css", b.href
        },
        defaultTheme: "default-bright"
    }
}]), angular.module("mpk").factory("fileService", function() {
    return {
        saveBlob: function(a, b) {
            return saveAs(a, b)
        }
    }
}), angular.module("mpk").controller("ApplicationController", ["$scope", "$window", "kanbanRepository", "themesProvider", "$routeParams", "$location", function(a, b, c, d, e, f, g) {
    function h(a) {
        return Math.floor(100 / a * 100) / 100
    }

    function i(b) {
        a.infoMessage = "", a.showInfo = !0, a.showError = !0, a.showSpinner = !1, a.errorMessage = b
    }

    function j(a) {
        return Object.keys(a.all())
    }
    a.colorOptions = ["FFFFFF", "DBDBDB", "FFB5B5", "FF9E9E", "FCC7FC", "FC9AFB", "CCD0FC", "989FFA", "CFFAFC", "9EFAFF", "94D6FF", "C1F7C2", "A2FCA3", "FAFCD2", "FAFFA1", "FCE4D4", "FCC19D"], a.$on("NewKanbanAdded", function() {
        a.showNewKanban = !1, a.kanban = c.getLastUsed(), a.allKanbans = Object.keys(c.all()), a.selectedToOpen = a.kanban.name, f.path("/kanban/" + a.kanban.name), a.switchToList = a.allKanbans.slice(0), a.switchToList.splice(0, 0, "Switch to ...")
    }), a.$on("ColumnsChanged", function() {
        a.columnWidth = h(a.kanban.columns.length)
    }), a.kanbanMenu = {}, a.cloudMenu = {}, a.kanbanMenu.openNewKanban = function() {
        a.$broadcast("OpenNewKanban", j(c))
    }, a.kanbanMenu["delete"] = function() {
        if (confirm("You sure you want to delete the entire Kanban?")) {
            $.ajax({
                url: '/kanban/projects/destroy.json',
                data: {
                    project_name: e.kanbanName,
                    project_id: c.kanbansByName[e.kanbanName].id
                },
                type: 'DELETE',
                async: false,
                success: function (json) {
                    if(json['success'])
                    {
                        c.remove(a.kanban.name);
                        var b = j(c);
                        c.setLastUsed(b.length > 0 ? b[0] : void 0), a.kanban = void 0, a.allKanbans = Object.keys(c.all()), a.allKanbans.length > 0 && a.switchToKanban(a.allKanbans[0]), a.switchToList = a.allKanbans.slice(0), a.switchToList.splice(0, 0, "Switch to ...")
                    }
                    else
                        alert(json['errors'])
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                }
            })
        }
        return !1
    }, a.kanbanMenu.openSwitchTheme = function() {
        a.$broadcast("OpenSwitchTheme", c.getTheme())
    }, a.kanbanMenu.openArchive = function(b) {
        a.$broadcast("OpenArchive", b)
    }, a.kanbanMenu.openExport = function(b, c) {
        a.$broadcast("OpenExport", b, c)
    }, a.kanbanMenu.openImport = function() {
        a.$broadcast("OpenImport")
    }, a.cloudMenu.openCloudSetup = function() {
        a.$broadcast("OpenCloudSetup")
    }, a.cloudMenu.upload = function() {
        if (!g.isConfigurationValid()) return a.openCloudSetup(!0);
        var b = c.upload();
        return a.errorMessage = "", a.showError = !1, a.infoMessage = "Uploading Kanban ...", a.showInfo = !0, a.showSpinner = !0, b.then(function(b) {
            b.data.success ? (c.setLastUpdated(b.data.lastUpdated).save(), a.infoMessage = "", a.showInfo = !1, a.showSpinner = !1) : (i(b.data.error), console.error(b))
        }, function() {
            a.infoMessage = "", a.showInfo = !0, a.showSpinner = !1, a.showError = !0, a.errorMessage = "There was a problem uploading your Kanban."
        }), !1
    }, a.cloudMenu.download = function() {
        if (!g.isConfigurationValid()) return a.openCloudSetup(!0);
        a.infoMessage = "Downloading your Kanban ...", a.showSpinner = !0, a.showError = !1, a.errorMessage = "";
        var d = c.download();
        return d.success(function(a) {
            if (a.success) {
                var d = c.saveDownloadedKanban(a.kanban, a.lastUpdated);
                d.success ? (void 0 == c.getLastUsed() && (c.setLastUsed(j(c)[0]), c.save()), b.location.reload()) : i(d.message)
            } else i(a.error)
        }).error(function() {
            a.infoMessage = "", a.showInfo = !0, a.showError = !0, a.showSpinner = !1, a.errorMessage = "Problem Downloading your Kanban. Check Internet connectivity and try again."
        }), !1
    }, a.editingKanbanName = function() {
        a.editingName = !0
    }, a.editingName = !1, a.rename = function() {
        $.ajax({
            url: '/kanban/projects/update.json',
            data: {
                project_name: e.kanbanName,
                project_id: c.kanbansByName[e.kanbanName].id,
                new_name: a.newName
            },
            type: 'POST',
            async: false,
            success: function (json) {
                c.renameLastUsedTo(a.newName), c.save(), a.allKanbans = Object.keys(c.all()), a.editingName = !1, a.switchToKanban(a.newName)
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
            }
        })
    }, a.openKanbanShortcut = function() {
        a.$broadcast("TriggerOpen")
    }, a.switchToKanban = function(b) {
        "Switch to ..." != b && (a.kanban = c.get(b), c.setLastUsed(b), a.newName = b, f.path("/kanban/" + b), c.save(), a.switchTo = "Switch to ...")
    }, a.openHelpShortcut = function() {
        a.$broadcast("TriggerHelp")
    }, a.spinConfig = {
        lines: 10,
        length: 3,
        width: 2,
        radius: 5
    };
    $.ajax({
        url: '/kanban/projects/index.json',
        data: {project_name: e.kanbanName},
        type: 'POST',
        async: false,
        success: function (json) {
            localStorage.setItem("myPersonalKanban", angular.toJson(json['data'], !1))
            var k = new Kanban("Kanban name", 0),
                l = c.load();
            l && (void 0 != e.kanbanName && c.get(e.kanbanName) ? k = c.get(e.kanbanName) : void 0 != c.getLastUsed() && (k = c.getLastUsed(), f.path("/kanban/" + k.name))), a.kanban = k, a.allKanbans = Object.keys(c.all()), a.selectedToOpen = a.newName = k.name, a.switchToList = a.allKanbans.slice(0), a.switchToList.splice(0, 0, "Switch to ..."), a.switchTo = "Switch to ...", a.$watch("kanban", function() {
                c.save()
            }, !0), a.columnHeight = angular.element(b).height() - 110, a.columnWidth = h(a.kanban.columns.length), a.triggerOpen = function() {
                a.$broadcast("TriggerOpenKanban")
            }, void 0 != c.getTheme() && "" != c.getTheme() && d.setCurrentTheme(c.getTheme())
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
        }
    })

}]);
var NewKanbanController = ["$scope", "kanbanRepository", "kanbanManipulator", function(a, b, c) {
    a.model = {}, a.$on("OpenNewKanban", function(b, c) {
        a.model.kanbanNames = c, a.model.kanbanName = "", a.model.numberOfColumns = 3, a.model.useTemplate = "", a.showNewKanban = !0
    }), a.createNew = function() {
        if (!this.newKanbanForm.$valid) return !1;
        var d = new Kanban(a.model.kanbanName, a.model.numberOfColumns);
        a.showNewKanban = false;
        $.ajax({
            url: '/kanban/projects/create.json',
            data : d,
            type: 'POST',
            success: function(json)
            {
                if(json['success'])
                {
                    for (var f = 1; f < parseInt(a.model.numberOfColumns) + 1; f++) c.addColumn(d, "Column " + f);
                    b.add(d);
                    a.kanbanName = ""
                    a.numberOfColumns = 3;
                    b.setLastUsed(d.name);
                    a.$emit("NewKanbanAdded");
                    localStorage.setItem("myPersonalKanban", angular.toJson(json['data'], !1))
                }
                else
                {
                    alert(json['errors'])
                }

            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
            }
            //
        })
    }
}];
angular.module("mpk").controller("NewKanbanController", NewKanbanController);
var CardController = ["$scope", function(a) {
    a.card = {},
        a.$on("OpenCardDetails", function(b, c) {
            a.card = c;
            old_card = {
                name: c.name,
                details: c.details,
                color: c.color
            };
            a.showCardDetails = !0
        }), a.editCard = function(card){
        data = {
            card_id: card.id,
            updates: {
                name: card.name,
                color: card.color,
                description: card.details
            }
        }
        $.ajax({
            url: '/kanban/cards/update.json',
            type: 'PUT',
            data: data,
            async: false,
            success: function(json){
                if(json['success']){
                    a.showCardDetails = false;
                }
                else
                    alert(json['errors'])
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
            }

        })
    }, a.revertCard = function(card){
        card.name = old_card.name
        card.details = old_card.details
        card.color = old_card.color
    }
}];
mpkModule.controller("CardController", CardController);
var ColumnSettingsController = ["$scope", "$timeout", function(a, b) {
    a.model = {
        column: {},
        kanban: {},
        columnName: "",
        color: "",
        limit: "",
        showWarning: !1,
        deleteDisabled: !0
    }, a.$on("OpenColumnSettings", function(b, c, d) {
        a.showColumnSettings = !0, a.model = {
            column: d,
            kanban: c,
            columnName: d.name,
            showWarning: !1,
            deleteDisabled: !0
        }, void 0 != d.settings && void 0 != d.settings.color && (a.model.color = d.settings.color), d.settings && d.settings.limit && (a.model.limit = d.settings.limit)
    }), a.$on("CloseColumnSettings", function() {
        a.showColumnSettings = !1
    }), a.update = function() {
        // TODO Code update column name
        var b = a.model.column;
        data = {
            column: a.model.column.name,
            column_id: a.model.column.id,
            project: a.model.kanban.name,
            project_id: a.model.kanban.id,
            updates: {
                name: a.model.columnName,
                color: a.model.color,
                limit: a.model.limit
            }
        }
        $.ajax({
            url: '/kanban/columns/update.json',
            type: 'PUT',
            data: data,
            async: false,
            success: function(json){
                if(json['success']){
                    a.showColumnSettings = !1;
                    return b.name = a.model.columnName, void 0 == b.settings && (b.settings = {}), b.settings.color = a.model.color, "" != a.model.limit && (b.settings.limit = a.model.limit), !0
                }
                else
                    alert(json['errors'])
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
            }

        })
    }, a["delete"] = function() {
        if(a.model.showWarning)
        {
            data = {
                column: a.model.column.name,
                column_id: a.model.column.id,
                project: a.model.kanban.name,
                project_id: a.model.kanban.id
            }
            $.ajax({
                url: '/kanban/columns/destroy.json',
                type: 'DELETE',
                data: data,
                async: false,
                success: function(json){
                    if(json['success']){
                        a.$emit("DeleteColumn", a.model.column);
                        a.showColumnSettings = !1
                    }
                    else
                        alert(json["errors"])
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                }

            })

        }  else{
            a.model.showWarning = !0;
            b(function() {
                a.model.deleteDisabled = !1
            }, 2e3)
        }
    }, a.addColumn = function(b) {
        data = {
            column: a.model.column.name,
            column_id: a.model.column.id,
            project: a.model.kanban.name,
            project_id: a.model.kanban.id,
            create: {
                name: a.model.columnName,
                settings: {
                    color: a.model.color,
                    limit: a.model.limit
                }
            }
        }
        $.ajax({
            url: '/kanban/columns/create.json',
            type: 'POST',
            data: data,
            async: false,
            success: function(json){
                if(json['success'])
                {
                    id = json['id']
                    k = new KanbanColumn(a.model.columnName, {color: a.model.color,
                        limit: a.model.limit}, id)
                    a.$emit("AddColumn", a.model.column, b, k)
                }
                else
                    alert(json['error'])

            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
            }
        })

    }
}];
angular.module("mpk").controller("ColumnSettingsController", ColumnSettingsController);
var NewKanbanCardController = ["$scope", "kanbanManipulator", function(a, b) {
    a.master = {
        title: "",
        details: "",
        cardColor: a.colorOptions[0]
    }, a.newCard = {}, a.$on("AddNewCard", function(b, c) {
        a.kanbanColumnName = c.name, a.column = c, a.newCard = angular.copy(a.master), a.showNewCard = !0
    }), a.addNewCard = function(c) {
        if(this.newCardForm.$valid){
            data = {
                project: a.kanban.name,
                project_id: a.kanban.id,
                column: a.column.name,
                column_id: a.column.id,
                card: {
                    name: c.title,
                    description: c.details,
                    color: c.cardColor
                }
            }
            a.showNewCard = false;
            $.ajax({
                url: '/kanban/cards/create.json',
                data: data,
                type: 'POST',
                success: function(json){
                    if(json['success']){
                        id= json['id']
                        b.addCardToColumn(a.kanban, a.column, c.title, c.details, c.cardColor, id);
                        a.newCard = angular.copy(a.master);
                    }
                    else
                        alert(json['errors'])
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                }
            })
        }
        else
            return !1
    }
}];
angular.module("mpk").controller("NewKanbanCardController", NewKanbanCardController), angular.module("mpk").controller("KanbanController", ["$scope", "kanbanManipulator", function(a, b) {
    a.addNewCard = function(b) {
        a.$broadcast("AddNewCard", b)
    }, a["delete"] = function(c, d) {
        confirm("You sure?") && b.removeCardFromColumn(a.kanban, d, c)
    }, a.openCardDetails = function(b) {
        a.$broadcast("OpenCardDetails", b)
    }, a.detailsFor = function(a) {
        return void 0 !== a.details && "" !== a.details ? a.details : a.name
    }, a.columnLimitsTextFor = function(a) {
        return a.settings && "" != a.settings.limit && void 0 != a.settings.limit ? a.cards.length + " of " + a.settings.limit : a.cards.length
    }, a.columnLimitsReached = function(a) {
        return void 0 == a.settings || "" == a.settings.limit || void 0 == a.settings.limit ? !1 : a.settings.limit <= a.cards.length
    }, a.colorFor = function(b) {
        return void 0 !== b.color && "" !== b.color ? b.color : a.colorOptions[0]
    }, a.isLastColumn = function(a, b) {
        function c(a) {
            return a[a.length - 1]
        }
        return c(b.columns).name == a
    }, a.archive = function(a, c, d) {
        return b.archiveCard(a, c, d)
    }, a.columnSettings = function(b, c) {
        a.$broadcast("OpenColumnSettings", b, c)
    }, a.sortableClassFor = function(a) {
        return a.settings && a.settings.limit && "" != a.settings.limit && a.settings.limit <= a.cards.length ? "cards-no-sort" : "cards"
    }, a.$on("DeleteColumn", function(c, d) {
        b.removeColumn(a.kanban, d), a.$emit("ColumnsChanged")
    }), a.$on("AddColumn", function(c, d, e,n) {
        b.addColumnNextToColumn(a.kanban, d, e,n ), a.$emit("ColumnsChanged"), a.$broadcast("CloseColumnSettings")
    })
}]);
var SwitchThemeController = ["$scope", "themesProvider", "kanbanRepository", function(a, b, c) {
    a.model = {}, a.model.themes = b.getThemes();
    var d = c.getTheme();
    (void 0 == d || "" == d) && (d = b.defaultTheme), a.model.selectedTheme = d, a.switchTheme = function() {
        b.setCurrentTheme(a.model.selectedTheme), c.setTheme(a.model.selectedTheme)
    }, a.$on("OpenSwitchTheme", function() {
        a.showSwitchTheme = !0
    })
}];
angular.module("mpk").controller("SwitchThemeController", SwitchThemeController);
angular.module("mpk").controller("ExportController", ["$scope", "kanbanRepository", "fileService", function(a, b, c) {
    a.model = {
        exportAll: !1,
        allKanbanNames: [],
        selectedKanban: ""
    }, a.showExportModal = !1, a.$on("OpenExport", function(b, c, d) {
        a.model.allKanbanNames = c, a.model.selectedKanban = d, a.showExportModal = !0
    }), a.doExport = function() {
        var d = null,
            e = a.model.selectedKanban + "-export.json";
        if (a.model.exportAll) {
            var f = b.all();
            d = new Blob([angular.toJson(f, !0)], {
                type: "application/json;charset=utf-8"
            }), e = "all-kanbans-export.json"
        } else {
            var g = b.get(a.model.selectedKanban);
            d = new Blob([angular.toJson(g, !0)], {
                type: "application/json;charset=utf-8"
            })
        }
        return c.saveBlob(d, e), a.showExportModal = !1, !0
    }
}]), angular.module("mpk").controller("ImportController", ["$scope", "kanbanRepository", function(a, b) {
    a.model = {
        file: "",
        readError: !1,
        fileSelected: !1
    }, a.showImportModal = !1, a.$on("OpenImport", function() {
        a.model = {
            file: "",
            readError: !1,
            fileSelected: !1
        }, a.showImportModal = !0
    }), a["import"] = function() {
        function c(a) {
            var b = Object.keys(a);
            return b.lastIndexOf("columns") > -1
        }
        if ("" != a.model.file) try {
            var d = angular.fromJson(a.model.file);
            if (c(d)) {
                var e = {};
                e[d.name] = d, b["import"](e)
            } else b["import"](d);
            a.$emit("DownloadFinished"), a.showImportModal = !1
        } catch (f) {
            a.model.readError = !0
        } else a.model.readError = !0
    }
}]), angular.module("mpk").controller("ArchiveController", ["$scope", "kanbanManipulator", function(a, b) {
    function c(a) {
        var b = [];
        return angular.forEach(a, function(a) {
            b.push({
                card: a.card,
                archivedOn: a.archivedOn,
                selected: !1,
                original: a
            })
        }), b
    }
    a.model = {
        kanban: {},
        archived: [],
        selectedCards: []
    }, a.showArchive = !1, a.$on("OpenArchive", function(b, d) {
        a.model.archived = c(d.archived), a.model.kanban = d, a.model.selectedCards = [], a.showArchive = !0
    }), a.formatDate = function(a) {
        var a = new Date(Date.parse(a));
        return a.toUTCString()
    }, a.unarchiveSelected = function() {
        // TODO CODE FOR INARCHIVE
        angular.forEach(a.model.archived, function(c) {
            c.selected && (a.model.archived.splice(a.model.archived.indexOf(c), 1), b.unarchiveCard(a.model.kanban, c.original))
        })
    }, a.deleteSelected = function() {
        // TODO FOR DELETE ARCHIVE CARD
        angular.forEach(a.model.archived, function(c) {
            c.selected && (a.model.archived.splice(a.model.archived.indexOf(c), 1), b.removeFromArchive(a.model.kanban, c.original))
        })
    }
}]), angular.module("mpk").directive("colorSelector", function() {
    return {
        restrict: "E",
        scope: {
            options: "=",
            model: "=ngModel",
            prefix: "@",
            showRadios: "=",
            showHexCode: "="
        },
        require: "ngModel",
        template: '<span ng-show="showHexCode">&nbsp;#{{model}}</span><div class="pull-left" ng-repeat="option in options" ng-model="option">\n	<label class="colorBox" for="{{prefix}}{{option}}" ng-class="{selected: option == model}" style="background-color: #{{option}};" ng-click="selectColor(option)"></label>\n	<br ng-show="showRadios"/>\n	<input type="radio" id="{{prefix}}{{option}}" name="{{prefix}}" value="{{option}}" ng-show="showRadios" ng-model="model"/>\n</div>\n',
        link: function(a) {
            (void 0 === a.model || "" === a.model) && (a.model = a.options[0]), a.selectColor = function(b) {
                a.model = b
            }
        }
    }
}), angular.module("mpk").directive("focusMe", ["$timeout", function(a) {
    return {
        link: function(b, c, d) {
            d.focusMe ? b.$watch(d.focusMe, function(b) {
                b === !0 && a(function() {
                    c[0].focus()
                })
            }) : a(function() {
                c[0].focus()
            })
        }
    }
}]), angular.module("mpk").value("uiSortableConfig", {}).directive("uiSortable", ["uiSortableConfig", "$timeout", "$log", function(a, b, c) {
    return {
        require: "?ngModel",
        link: function(d, e, f, g) {
            function h(a, b) {
                return b && "function" == typeof b ? function(c, d) {
                    a(c, d), b(c, d)
                } : a
            }
            var i, j = {},
                k = {
                    receive: null,
                    remove: null,
                    start: null,
                    stop: null,
                    update: null
                };
            angular.extend(j, a), g ? (d.$watch(f.ngModel + ".length", function() {
                b(function() {
                    e.sortable("refresh")
                })
            }), k.start = function(a, b) {
                b.item.sortable = {
                    index: b.item.index(),
                    cancel: function() {
                        b.item.sortable._isCanceled = !0
                    },
                    isCanceled: function() {
                        return b.item.sortable._isCanceled
                    },
                    _isCanceled: !1
                }
            }, k.activate = function() {
                i = e.contents();
                var a = e.sortable("option", "placeholder");
                if (a && a.element && "function" == typeof a.element) {
                    var b = a.element();
                    b.jquery || (b = angular.element(b));
                    var c = e.find('[class="' + b.attr("class") + '"]');
                    i = i.not(c)
                }
            }, k.update = function(a, b) {
                b.item.sortable.received || (b.item.sortable.dropindex = b.item.index(), b.item.sortable.droptarget = b.item.parent(), e.sortable("cancel")), i.detach(), "clone" === e.sortable("option", "helper") && (i = i.not(i.last())), i.appendTo(e), b.item.sortable.received && !b.item.sortable.isCanceled() && d.$apply(function() {
                    g.$modelValue.splice(b.item.sortable.dropindex, 0, b.item.sortable.moved)
                })
            }, k.stop = function(a, b) {
                !b.item.sortable.received && "dropindex" in b.item.sortable && !b.item.sortable.isCanceled() ? d.$apply(function() {
                    g.$modelValue.splice(b.item.sortable.dropindex, 0, g.$modelValue.splice(b.item.sortable.index, 1)[0])
                }) : "dropindex" in b.item.sortable && !b.item.sortable.isCanceled() || "clone" === e.sortable("option", "helper") || i.detach().appendTo(e)
            }, k.receive = function(a, b) {
                b.item.sortable.received = !0
            }, k.remove = function(a, b) {
                b.item.sortable.isCanceled() || d.$apply(function() {
                    b.item.sortable.moved = g.$modelValue.splice(b.item.sortable.index, 1)[0]
                })
            }, d.$watch(f.uiSortable, function(a) {
                angular.forEach(a, function(a, b) {
                    k[b] && ("stop" === b && (a = h(a, function() {
                        d.$apply()
                    })), a = h(k[b], a)), e.sortable("option", b, a)
                })
            }, !0), angular.forEach(k, function(a, b) {
                j[b] = h(a, j[b])
            })) : c.info("ui.sortable: ngModel not provided!", e), e.sortable(j)
        }
    }
}]), angular.module("mpk").directive("readFile", function() {
    return {
        restrict: "A",
        scope: {
            model: "=ngModel"
        },
        require: "ngModel",
        link: function(a, b) {
            b.bind("change", function(b) {
                a.readError = !1;
                var c = (b.srcElement || b.target).files[0],
                    d = new FileReader;
                d.onload = function(b) {
                    a.$apply(function() {
                        a.model = b.target.result
                    })
                }, d.readAsText(c)
            })
        }
    }
}), angular.module("mpk").directive("mpkModal", function() {
    return {
        template: '<div class="modal fade"><div class="modal-dialog" style="{{ style }}" ><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title">{{ title }}</h4></div><div class="modal-body" ng-transclude></div></div></div></div>',
        restrict: "E",
        transclude: !0,
        replace: !0,
        scope: !0,
        link: function(a, b, c) {
            a.title = c.title, a.style = "", c.modalStyle && (a.style = c.modalStyle), a.$watch(c.visible, function(a) {
                $(b).modal(1 == a ? "show" : "hide")
            }), $(b).on("shown.bs.modal", function() {
                a.$apply(function() {
                    a.$parent[c.visible] = !0
                })
            }), $(b).on("hidden.bs.modal", function() {
                a.$apply(function() {
                    a.$parent[c.visible] = !1
                })
            })
        }
    }
}), angular.module("mpk").filter("cardDetails", function() {
    return function(a) {
        return void 0 == a || "" === a ? a : a.replace(/&#10;/g, "<br />")
    }
}), angular.module("mpk").filter("archiveByCardName", function() {
    return function(a, b) {
        var c = [],
            d = b || "";
        return angular.forEach(a, function(a) {
            a.card.name.toLowerCase().indexOf(d.toLowerCase()) > -1 && c.push(a)
        }), c.reverse()
    }
}), angular.module("mpk").factory("cryptoService", function() {
    return {
        md5Hash: function(a) {
            return CryptoJS.MD5(a).toString()
        },
        encrypt: function(a, b) {
            var c = CryptoJS.enc.Utf8.parse(a);
            return CryptoJS.Rabbit.encrypt(c, b).toString()
        },
        decrypt: function(a, b) {
            var c = CryptoJS.Rabbit.decrypt(a, b);
            return CryptoJS.enc.Utf8.stringify(c)
        }
    }
}), angular.module("mpk").directive("spin", function() {
    var a = function(a, b) {
        b.color || (b.color = a)
    };
    return {
        restrict: "A",
        transclude: !0,
        replace: !0,
        template: "<div ng-transclude></div>",
        scope: {
            config: "=spin",
            spinif: "=spinIf"
        },
        link: function(b, c, d) {
            var e, f = c.css("color"),
                g = !1,
                h = !!b.config.hideElement;
            a(f, b.config), e = new Spinner(b.config), e.spin(c[0]), b.$watch("config", function(a, b) {
                a != b && (e.stop(), h = !!a.config.hideElement, e = new Spinner(a), g || e.spin(c[0]))
            }, !0), d.hasOwnProperty("spinIf") && b.$watch("spinif", function(a) {
                a ? (e.spin(c[0]), h && c.css("display", ""), g = !1) : (e.stop(), h && c.css("display", "none"), g = !0)
            }), b.$on("$destroy", function() {
                e.stop()
            })
        }
    }
})