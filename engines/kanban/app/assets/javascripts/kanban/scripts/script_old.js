function Kanban(a, b) {
    return {
        name: a,
        numberOfColumns: b,
        columns: [],
        archived: [],
        settings: {}
    }
}

function KanbanColumn(a) {
    return {
        name: a,
        cards: [],
        settings: {}
    }
}

function KanbanColumn(a, b) {
    return {
        name: a,
        cards: [],
        settings: b
    }
}

function KanbanCard(a, b, c) {
    return this.name = a, this.details = b, this.color = c, this
}
var CryptoJS = CryptoJS || function(a, b) {
        var c = {},
            d = c.lib = {},
            e = function() {},
            f = d.Base = {
                extend: function(a) {
                    e.prototype = this;
                    var b = new e;
                    return a && b.mixIn(a), b.hasOwnProperty("init") || (b.init = function() {
                        b.$super.init.apply(this, arguments)
                    }), b.init.prototype = b, b.$super = this, b
                },
                create: function() {
                    var a = this.extend();
                    return a.init.apply(a, arguments), a
                },
                init: function() {},
                mixIn: function(a) {
                    for (var b in a) a.hasOwnProperty(b) && (this[b] = a[b]);
                    a.hasOwnProperty("toString") && (this.toString = a.toString)
                },
                clone: function() {
                    return this.init.prototype.extend(this)
                }
            },
            g = d.WordArray = f.extend({
                init: function(a, c) {
                    a = this.words = a || [], this.sigBytes = c != b ? c : 4 * a.length
                },
                toString: function(a) {
                    return (a || i).stringify(this)
                },
                concat: function(a) {
                    var b = this.words,
                        c = a.words,
                        d = this.sigBytes;
                    if (a = a.sigBytes, this.clamp(), d % 4)
                        for (var e = 0; a > e; e++) b[d + e >>> 2] |= (c[e >>> 2] >>> 24 - 8 * (e % 4) & 255) << 24 - 8 * ((d + e) % 4);
                    else if (65535 < c.length)
                        for (e = 0; a > e; e += 4) b[d + e >>> 2] = c[e >>> 2];
                    else b.push.apply(b, c);
                    return this.sigBytes += a, this
                },
                clamp: function() {
                    var b = this.words,
                        c = this.sigBytes;
                    b[c >>> 2] &= 4294967295 << 32 - 8 * (c % 4), b.length = a.ceil(c / 4)
                },
                clone: function() {
                    var a = f.clone.call(this);
                    return a.words = this.words.slice(0), a
                },
                random: function(b) {
                    for (var c = [], d = 0; b > d; d += 4) c.push(4294967296 * a.random() | 0);
                    return new g.init(c, b)
                }
            }),
            h = c.enc = {},
            i = h.Hex = {
                stringify: function(a) {
                    var b = a.words;
                    a = a.sigBytes;
                    for (var c = [], d = 0; a > d; d++) {
                        var e = b[d >>> 2] >>> 24 - 8 * (d % 4) & 255;
                        c.push((e >>> 4).toString(16)), c.push((15 & e).toString(16))
                    }
                    return c.join("")
                },
                parse: function(a) {
                    for (var b = a.length, c = [], d = 0; b > d; d += 2) c[d >>> 3] |= parseInt(a.substr(d, 2), 16) << 24 - 4 * (d % 8);
                    return new g.init(c, b / 2)
                }
            },
            j = h.Latin1 = {
                stringify: function(a) {
                    var b = a.words;
                    a = a.sigBytes;
                    for (var c = [], d = 0; a > d; d++) c.push(String.fromCharCode(b[d >>> 2] >>> 24 - 8 * (d % 4) & 255));
                    return c.join("")
                },
                parse: function(a) {
                    for (var b = a.length, c = [], d = 0; b > d; d++) c[d >>> 2] |= (255 & a.charCodeAt(d)) << 24 - 8 * (d % 4);
                    return new g.init(c, b)
                }
            },
            k = h.Utf8 = {
                stringify: function(a) {
                    try {
                        return decodeURIComponent(escape(j.stringify(a)))
                    } catch (b) {
                        throw Error("Malformed UTF-8 data")
                    }
                },
                parse: function(a) {
                    return j.parse(unescape(encodeURIComponent(a)))
                }
            },
            l = d.BufferedBlockAlgorithm = f.extend({
                reset: function() {
                    this._data = new g.init, this._nDataBytes = 0
                },
                _append: function(a) {
                    "string" == typeof a && (a = k.parse(a)), this._data.concat(a), this._nDataBytes += a.sigBytes
                },
                _process: function(b) {
                    var c = this._data,
                        d = c.words,
                        e = c.sigBytes,
                        f = this.blockSize,
                        h = e / (4 * f),
                        h = b ? a.ceil(h) : a.max((0 | h) - this._minBufferSize, 0);
                    if (b = h * f, e = a.min(4 * b, e), b) {
                        for (var i = 0; b > i; i += f) this._doProcessBlock(d, i);
                        i = d.splice(0, b), c.sigBytes -= e
                    }
                    return new g.init(i, e)
                },
                clone: function() {
                    var a = f.clone.call(this);
                    return a._data = this._data.clone(), a
                },
                _minBufferSize: 0
            });
        d.Hasher = l.extend({
            cfg: f.extend(),
            init: function(a) {
                this.cfg = this.cfg.extend(a), this.reset()
            },
            reset: function() {
                l.reset.call(this), this._doReset()
            },
            update: function(a) {
                return this._append(a), this._process(), this
            },
            finalize: function(a) {
                return a && this._append(a), this._doFinalize()
            },
            blockSize: 16,
            _createHelper: function(a) {
                return function(b, c) {
                    return new a.init(c).finalize(b)
                }
            },
            _createHmacHelper: function(a) {
                return function(b, c) {
                    return new m.HMAC.init(a, c).finalize(b)
                }
            }
        });
        var m = c.algo = {};
        return c
    }(Math);
! function(a) {
    function b(a, b, c, d, e, f, g) {
        return a = a + (b & c | ~b & d) + e + g, (a << f | a >>> 32 - f) + b
    }

    function c(a, b, c, d, e, f, g) {
        return a = a + (b & d | c & ~d) + e + g, (a << f | a >>> 32 - f) + b
    }

    function d(a, b, c, d, e, f, g) {
        return a = a + (b ^ c ^ d) + e + g, (a << f | a >>> 32 - f) + b
    }

    function e(a, b, c, d, e, f, g) {
        return a = a + (c ^ (b | ~d)) + e + g, (a << f | a >>> 32 - f) + b
    }
    for (var f = CryptoJS, g = f.lib, h = g.WordArray, i = g.Hasher, g = f.algo, j = [], k = 0; 64 > k; k++) j[k] = 4294967296 * a.abs(a.sin(k + 1)) | 0;
    g = g.MD5 = i.extend({
        _doReset: function() {
            this._hash = new h.init([1732584193, 4023233417, 2562383102, 271733878])
        },
        _doProcessBlock: function(a, f) {
            for (var g = 0; 16 > g; g++) {
                var h = f + g,
                    i = a[h];
                a[h] = 16711935 & (i << 8 | i >>> 24) | 4278255360 & (i << 24 | i >>> 8)
            }
            var g = this._hash.words,
                h = a[f + 0],
                i = a[f + 1],
                k = a[f + 2],
                l = a[f + 3],
                m = a[f + 4],
                n = a[f + 5],
                o = a[f + 6],
                p = a[f + 7],
                q = a[f + 8],
                r = a[f + 9],
                s = a[f + 10],
                t = a[f + 11],
                u = a[f + 12],
                v = a[f + 13],
                w = a[f + 14],
                x = a[f + 15],
                y = g[0],
                z = g[1],
                A = g[2],
                B = g[3],
                y = b(y, z, A, B, h, 7, j[0]),
                B = b(B, y, z, A, i, 12, j[1]),
                A = b(A, B, y, z, k, 17, j[2]),
                z = b(z, A, B, y, l, 22, j[3]),
                y = b(y, z, A, B, m, 7, j[4]),
                B = b(B, y, z, A, n, 12, j[5]),
                A = b(A, B, y, z, o, 17, j[6]),
                z = b(z, A, B, y, p, 22, j[7]),
                y = b(y, z, A, B, q, 7, j[8]),
                B = b(B, y, z, A, r, 12, j[9]),
                A = b(A, B, y, z, s, 17, j[10]),
                z = b(z, A, B, y, t, 22, j[11]),
                y = b(y, z, A, B, u, 7, j[12]),
                B = b(B, y, z, A, v, 12, j[13]),
                A = b(A, B, y, z, w, 17, j[14]),
                z = b(z, A, B, y, x, 22, j[15]),
                y = c(y, z, A, B, i, 5, j[16]),
                B = c(B, y, z, A, o, 9, j[17]),
                A = c(A, B, y, z, t, 14, j[18]),
                z = c(z, A, B, y, h, 20, j[19]),
                y = c(y, z, A, B, n, 5, j[20]),
                B = c(B, y, z, A, s, 9, j[21]),
                A = c(A, B, y, z, x, 14, j[22]),
                z = c(z, A, B, y, m, 20, j[23]),
                y = c(y, z, A, B, r, 5, j[24]),
                B = c(B, y, z, A, w, 9, j[25]),
                A = c(A, B, y, z, l, 14, j[26]),
                z = c(z, A, B, y, q, 20, j[27]),
                y = c(y, z, A, B, v, 5, j[28]),
                B = c(B, y, z, A, k, 9, j[29]),
                A = c(A, B, y, z, p, 14, j[30]),
                z = c(z, A, B, y, u, 20, j[31]),
                y = d(y, z, A, B, n, 4, j[32]),
                B = d(B, y, z, A, q, 11, j[33]),
                A = d(A, B, y, z, t, 16, j[34]),
                z = d(z, A, B, y, w, 23, j[35]),
                y = d(y, z, A, B, i, 4, j[36]),
                B = d(B, y, z, A, m, 11, j[37]),
                A = d(A, B, y, z, p, 16, j[38]),
                z = d(z, A, B, y, s, 23, j[39]),
                y = d(y, z, A, B, v, 4, j[40]),
                B = d(B, y, z, A, h, 11, j[41]),
                A = d(A, B, y, z, l, 16, j[42]),
                z = d(z, A, B, y, o, 23, j[43]),
                y = d(y, z, A, B, r, 4, j[44]),
                B = d(B, y, z, A, u, 11, j[45]),
                A = d(A, B, y, z, x, 16, j[46]),
                z = d(z, A, B, y, k, 23, j[47]),
                y = e(y, z, A, B, h, 6, j[48]),
                B = e(B, y, z, A, p, 10, j[49]),
                A = e(A, B, y, z, w, 15, j[50]),
                z = e(z, A, B, y, n, 21, j[51]),
                y = e(y, z, A, B, u, 6, j[52]),
                B = e(B, y, z, A, l, 10, j[53]),
                A = e(A, B, y, z, s, 15, j[54]),
                z = e(z, A, B, y, i, 21, j[55]),
                y = e(y, z, A, B, q, 6, j[56]),
                B = e(B, y, z, A, x, 10, j[57]),
                A = e(A, B, y, z, o, 15, j[58]),
                z = e(z, A, B, y, v, 21, j[59]),
                y = e(y, z, A, B, m, 6, j[60]),
                B = e(B, y, z, A, t, 10, j[61]),
                A = e(A, B, y, z, k, 15, j[62]),
                z = e(z, A, B, y, r, 21, j[63]);
            g[0] = g[0] + y | 0, g[1] = g[1] + z | 0, g[2] = g[2] + A | 0, g[3] = g[3] + B | 0
        },
        _doFinalize: function() {
            var b = this._data,
                c = b.words,
                d = 8 * this._nDataBytes,
                e = 8 * b.sigBytes;
            c[e >>> 5] |= 128 << 24 - e % 32;
            var f = a.floor(d / 4294967296);
            for (c[(e + 64 >>> 9 << 4) + 15] = 16711935 & (f << 8 | f >>> 24) | 4278255360 & (f << 24 | f >>> 8), c[(e + 64 >>> 9 << 4) + 14] = 16711935 & (d << 8 | d >>> 24) | 4278255360 & (d << 24 | d >>> 8), b.sigBytes = 4 * (c.length + 1), this._process(), b = this._hash, c = b.words, d = 0; 4 > d; d++) e = c[d], c[d] = 16711935 & (e << 8 | e >>> 24) | 4278255360 & (e << 24 | e >>> 8);
            return b
        },
        clone: function() {
            var a = i.clone.call(this);
            return a._hash = this._hash.clone(), a
        }
    }), f.MD5 = i._createHelper(g), f.HmacMD5 = i._createHmacHelper(g)
}(Math);
var CryptoJS = CryptoJS || function(a, b) {
        var c = {},
            d = c.lib = {},
            e = function() {},
            f = d.Base = {
                extend: function(a) {
                    e.prototype = this;
                    var b = new e;
                    return a && b.mixIn(a), b.hasOwnProperty("init") || (b.init = function() {
                        b.$super.init.apply(this, arguments)
                    }), b.init.prototype = b, b.$super = this, b
                },
                create: function() {
                    var a = this.extend();
                    return a.init.apply(a, arguments), a
                },
                init: function() {},
                mixIn: function(a) {
                    for (var b in a) a.hasOwnProperty(b) && (this[b] = a[b]);
                    a.hasOwnProperty("toString") && (this.toString = a.toString)
                },
                clone: function() {
                    return this.init.prototype.extend(this)
                }
            },
            g = d.WordArray = f.extend({
                init: function(a, c) {
                    a = this.words = a || [], this.sigBytes = c != b ? c : 4 * a.length
                },
                toString: function(a) {
                    return (a || i).stringify(this)
                },
                concat: function(a) {
                    var b = this.words,
                        c = a.words,
                        d = this.sigBytes;
                    if (a = a.sigBytes, this.clamp(), d % 4)
                        for (var e = 0; a > e; e++) b[d + e >>> 2] |= (c[e >>> 2] >>> 24 - 8 * (e % 4) & 255) << 24 - 8 * ((d + e) % 4);
                    else if (65535 < c.length)
                        for (e = 0; a > e; e += 4) b[d + e >>> 2] = c[e >>> 2];
                    else b.push.apply(b, c);
                    return this.sigBytes += a, this
                },
                clamp: function() {
                    var b = this.words,
                        c = this.sigBytes;
                    b[c >>> 2] &= 4294967295 << 32 - 8 * (c % 4), b.length = a.ceil(c / 4)
                },
                clone: function() {
                    var a = f.clone.call(this);
                    return a.words = this.words.slice(0), a
                },
                random: function(b) {
                    for (var c = [], d = 0; b > d; d += 4) c.push(4294967296 * a.random() | 0);
                    return new g.init(c, b)
                }
            }),
            h = c.enc = {},
            i = h.Hex = {
                stringify: function(a) {
                    var b = a.words;
                    a = a.sigBytes;
                    for (var c = [], d = 0; a > d; d++) {
                        var e = b[d >>> 2] >>> 24 - 8 * (d % 4) & 255;
                        c.push((e >>> 4).toString(16)), c.push((15 & e).toString(16))
                    }
                    return c.join("")
                },
                parse: function(a) {
                    for (var b = a.length, c = [], d = 0; b > d; d += 2) c[d >>> 3] |= parseInt(a.substr(d, 2), 16) << 24 - 4 * (d % 8);
                    return new g.init(c, b / 2)
                }
            },
            j = h.Latin1 = {
                stringify: function(a) {
                    var b = a.words;
                    a = a.sigBytes;
                    for (var c = [], d = 0; a > d; d++) c.push(String.fromCharCode(b[d >>> 2] >>> 24 - 8 * (d % 4) & 255));
                    return c.join("")
                },
                parse: function(a) {
                    for (var b = a.length, c = [], d = 0; b > d; d++) c[d >>> 2] |= (255 & a.charCodeAt(d)) << 24 - 8 * (d % 4);
                    return new g.init(c, b)
                }
            },
            k = h.Utf8 = {
                stringify: function(a) {
                    try {
                        return decodeURIComponent(escape(j.stringify(a)))
                    } catch (b) {
                        throw Error("Malformed UTF-8 data")
                    }
                },
                parse: function(a) {
                    return j.parse(unescape(encodeURIComponent(a)))
                }
            },
            l = d.BufferedBlockAlgorithm = f.extend({
                reset: function() {
                    this._data = new g.init, this._nDataBytes = 0
                },
                _append: function(a) {
                    "string" == typeof a && (a = k.parse(a)), this._data.concat(a), this._nDataBytes += a.sigBytes
                },
                _process: function(b) {
                    var c = this._data,
                        d = c.words,
                        e = c.sigBytes,
                        f = this.blockSize,
                        h = e / (4 * f),
                        h = b ? a.ceil(h) : a.max((0 | h) - this._minBufferSize, 0);
                    if (b = h * f, e = a.min(4 * b, e), b) {
                        for (var i = 0; b > i; i += f) this._doProcessBlock(d, i);
                        i = d.splice(0, b), c.sigBytes -= e
                    }
                    return new g.init(i, e)
                },
                clone: function() {
                    var a = f.clone.call(this);
                    return a._data = this._data.clone(), a
                },
                _minBufferSize: 0
            });
        d.Hasher = l.extend({
            cfg: f.extend(),
            init: function(a) {
                this.cfg = this.cfg.extend(a), this.reset()
            },
            reset: function() {
                l.reset.call(this), this._doReset()
            },
            update: function(a) {
                return this._append(a), this._process(), this
            },
            finalize: function(a) {
                return a && this._append(a), this._doFinalize()
            },
            blockSize: 16,
            _createHelper: function(a) {
                return function(b, c) {
                    return new a.init(c).finalize(b)
                }
            },
            _createHmacHelper: function(a) {
                return function(b, c) {
                    return new m.HMAC.init(a, c).finalize(b)
                }
            }
        });
        var m = c.algo = {};
        return c
    }(Math);
! function() {
    var a = CryptoJS,
        b = a.lib.WordArray;
    a.enc.Base64 = {
        stringify: function(a) {
            var b = a.words,
                c = a.sigBytes,
                d = this._map;
            a.clamp(), a = [];
            for (var e = 0; c > e; e += 3)
                for (var f = (b[e >>> 2] >>> 24 - 8 * (e % 4) & 255) << 16 | (b[e + 1 >>> 2] >>> 24 - 8 * ((e + 1) % 4) & 255) << 8 | b[e + 2 >>> 2] >>> 24 - 8 * ((e + 2) % 4) & 255, g = 0; 4 > g && c > e + .75 * g; g++) a.push(d.charAt(f >>> 6 * (3 - g) & 63));
            if (b = d.charAt(64))
                for (; a.length % 4;) a.push(b);
            return a.join("")
        },
        parse: function(a) {
            var c = a.length,
                d = this._map,
                e = d.charAt(64);
            e && (e = a.indexOf(e), -1 != e && (c = e));
            for (var e = [], f = 0, g = 0; c > g; g++)
                if (g % 4) {
                    var h = d.indexOf(a.charAt(g - 1)) << 2 * (g % 4),
                        i = d.indexOf(a.charAt(g)) >>> 6 - 2 * (g % 4);
                    e[f >>> 2] |= (h | i) << 24 - 8 * (f % 4), f++
                }
            return b.create(e, f)
        },
        _map: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    }
}(),
    function(a) {
        function b(a, b, c, d, e, f, g) {
            return a = a + (b & c | ~b & d) + e + g, (a << f | a >>> 32 - f) + b
        }

        function c(a, b, c, d, e, f, g) {
            return a = a + (b & d | c & ~d) + e + g, (a << f | a >>> 32 - f) + b
        }

        function d(a, b, c, d, e, f, g) {
            return a = a + (b ^ c ^ d) + e + g, (a << f | a >>> 32 - f) + b
        }

        function e(a, b, c, d, e, f, g) {
            return a = a + (c ^ (b | ~d)) + e + g, (a << f | a >>> 32 - f) + b
        }
        for (var f = CryptoJS, g = f.lib, h = g.WordArray, i = g.Hasher, g = f.algo, j = [], k = 0; 64 > k; k++) j[k] = 4294967296 * a.abs(a.sin(k + 1)) | 0;
        g = g.MD5 = i.extend({
            _doReset: function() {
                this._hash = new h.init([1732584193, 4023233417, 2562383102, 271733878])
            },
            _doProcessBlock: function(a, f) {
                for (var g = 0; 16 > g; g++) {
                    var h = f + g,
                        i = a[h];
                    a[h] = 16711935 & (i << 8 | i >>> 24) | 4278255360 & (i << 24 | i >>> 8)
                }
                var g = this._hash.words,
                    h = a[f + 0],
                    i = a[f + 1],
                    k = a[f + 2],
                    l = a[f + 3],
                    m = a[f + 4],
                    n = a[f + 5],
                    o = a[f + 6],
                    p = a[f + 7],
                    q = a[f + 8],
                    r = a[f + 9],
                    s = a[f + 10],
                    t = a[f + 11],
                    u = a[f + 12],
                    v = a[f + 13],
                    w = a[f + 14],
                    x = a[f + 15],
                    y = g[0],
                    z = g[1],
                    A = g[2],
                    B = g[3],
                    y = b(y, z, A, B, h, 7, j[0]),
                    B = b(B, y, z, A, i, 12, j[1]),
                    A = b(A, B, y, z, k, 17, j[2]),
                    z = b(z, A, B, y, l, 22, j[3]),
                    y = b(y, z, A, B, m, 7, j[4]),
                    B = b(B, y, z, A, n, 12, j[5]),
                    A = b(A, B, y, z, o, 17, j[6]),
                    z = b(z, A, B, y, p, 22, j[7]),
                    y = b(y, z, A, B, q, 7, j[8]),
                    B = b(B, y, z, A, r, 12, j[9]),
                    A = b(A, B, y, z, s, 17, j[10]),
                    z = b(z, A, B, y, t, 22, j[11]),
                    y = b(y, z, A, B, u, 7, j[12]),
                    B = b(B, y, z, A, v, 12, j[13]),
                    A = b(A, B, y, z, w, 17, j[14]),
                    z = b(z, A, B, y, x, 22, j[15]),
                    y = c(y, z, A, B, i, 5, j[16]),
                    B = c(B, y, z, A, o, 9, j[17]),
                    A = c(A, B, y, z, t, 14, j[18]),
                    z = c(z, A, B, y, h, 20, j[19]),
                    y = c(y, z, A, B, n, 5, j[20]),
                    B = c(B, y, z, A, s, 9, j[21]),
                    A = c(A, B, y, z, x, 14, j[22]),
                    z = c(z, A, B, y, m, 20, j[23]),
                    y = c(y, z, A, B, r, 5, j[24]),
                    B = c(B, y, z, A, w, 9, j[25]),
                    A = c(A, B, y, z, l, 14, j[26]),
                    z = c(z, A, B, y, q, 20, j[27]),
                    y = c(y, z, A, B, v, 5, j[28]),
                    B = c(B, y, z, A, k, 9, j[29]),
                    A = c(A, B, y, z, p, 14, j[30]),
                    z = c(z, A, B, y, u, 20, j[31]),
                    y = d(y, z, A, B, n, 4, j[32]),
                    B = d(B, y, z, A, q, 11, j[33]),
                    A = d(A, B, y, z, t, 16, j[34]),
                    z = d(z, A, B, y, w, 23, j[35]),
                    y = d(y, z, A, B, i, 4, j[36]),
                    B = d(B, y, z, A, m, 11, j[37]),
                    A = d(A, B, y, z, p, 16, j[38]),
                    z = d(z, A, B, y, s, 23, j[39]),
                    y = d(y, z, A, B, v, 4, j[40]),
                    B = d(B, y, z, A, h, 11, j[41]),
                    A = d(A, B, y, z, l, 16, j[42]),
                    z = d(z, A, B, y, o, 23, j[43]),
                    y = d(y, z, A, B, r, 4, j[44]),
                    B = d(B, y, z, A, u, 11, j[45]),
                    A = d(A, B, y, z, x, 16, j[46]),
                    z = d(z, A, B, y, k, 23, j[47]),
                    y = e(y, z, A, B, h, 6, j[48]),
                    B = e(B, y, z, A, p, 10, j[49]),
                    A = e(A, B, y, z, w, 15, j[50]),
                    z = e(z, A, B, y, n, 21, j[51]),
                    y = e(y, z, A, B, u, 6, j[52]),
                    B = e(B, y, z, A, l, 10, j[53]),
                    A = e(A, B, y, z, s, 15, j[54]),
                    z = e(z, A, B, y, i, 21, j[55]),
                    y = e(y, z, A, B, q, 6, j[56]),
                    B = e(B, y, z, A, x, 10, j[57]),
                    A = e(A, B, y, z, o, 15, j[58]),
                    z = e(z, A, B, y, v, 21, j[59]),
                    y = e(y, z, A, B, m, 6, j[60]),
                    B = e(B, y, z, A, t, 10, j[61]),
                    A = e(A, B, y, z, k, 15, j[62]),
                    z = e(z, A, B, y, r, 21, j[63]);
                g[0] = g[0] + y | 0, g[1] = g[1] + z | 0, g[2] = g[2] + A | 0, g[3] = g[3] + B | 0
            },
            _doFinalize: function() {
                var b = this._data,
                    c = b.words,
                    d = 8 * this._nDataBytes,
                    e = 8 * b.sigBytes;
                c[e >>> 5] |= 128 << 24 - e % 32;
                var f = a.floor(d / 4294967296);
                for (c[(e + 64 >>> 9 << 4) + 15] = 16711935 & (f << 8 | f >>> 24) | 4278255360 & (f << 24 | f >>> 8), c[(e + 64 >>> 9 << 4) + 14] = 16711935 & (d << 8 | d >>> 24) | 4278255360 & (d << 24 | d >>> 8), b.sigBytes = 4 * (c.length + 1), this._process(), b = this._hash, c = b.words, d = 0; 4 > d; d++) e = c[d], c[d] = 16711935 & (e << 8 | e >>> 24) | 4278255360 & (e << 24 | e >>> 8);
                return b
            },
            clone: function() {
                var a = i.clone.call(this);
                return a._hash = this._hash.clone(), a
            }
        }), f.MD5 = i._createHelper(g), f.HmacMD5 = i._createHmacHelper(g)
    }(Math),
    function() {
        var a = CryptoJS,
            b = a.lib,
            c = b.Base,
            d = b.WordArray,
            b = a.algo,
            e = b.EvpKDF = c.extend({
                cfg: c.extend({
                    keySize: 4,
                    hasher: b.MD5,
                    iterations: 1
                }),
                init: function(a) {
                    this.cfg = this.cfg.extend(a)
                },
                compute: function(a, b) {
                    for (var c = this.cfg, e = c.hasher.create(), f = d.create(), g = f.words, h = c.keySize, c = c.iterations; g.length < h;) {
                        i && e.update(i);
                        var i = e.update(a).finalize(b);
                        e.reset();
                        for (var j = 1; c > j; j++) i = e.finalize(i), e.reset();
                        f.concat(i)
                    }
                    return f.sigBytes = 4 * h, f
                }
            });
        a.EvpKDF = function(a, b, c) {
            return e.create(c).compute(a, b)
        }
    }(), CryptoJS.lib.Cipher || function(a) {
    var b = CryptoJS,
        c = b.lib,
        d = c.Base,
        e = c.WordArray,
        f = c.BufferedBlockAlgorithm,
        g = b.enc.Base64,
        h = b.algo.EvpKDF,
        i = c.Cipher = f.extend({
            cfg: d.extend(),
            createEncryptor: function(a, b) {
                return this.create(this._ENC_XFORM_MODE, a, b)
            },
            createDecryptor: function(a, b) {
                return this.create(this._DEC_XFORM_MODE, a, b)
            },
            init: function(a, b, c) {
                this.cfg = this.cfg.extend(c), this._xformMode = a, this._key = b, this.reset()
            },
            reset: function() {
                f.reset.call(this), this._doReset()
            },
            process: function(a) {
                return this._append(a), this._process()
            },
            finalize: function(a) {
                return a && this._append(a), this._doFinalize()
            },
            keySize: 4,
            ivSize: 4,
            _ENC_XFORM_MODE: 1,
            _DEC_XFORM_MODE: 2,
            _createHelper: function(a) {
                return {
                    encrypt: function(b, c, d) {
                        return ("string" == typeof c ? o : n).encrypt(a, b, c, d)
                    },
                    decrypt: function(b, c, d) {
                        return ("string" == typeof c ? o : n).decrypt(a, b, c, d)
                    }
                }
            }
        });
    c.StreamCipher = i.extend({
        _doFinalize: function() {
            return this._process(!0)
        },
        blockSize: 1
    });
    var j = b.mode = {},
        k = function(b, c, d) {
            var e = this._iv;
            e ? this._iv = a : e = this._prevBlock;
            for (var f = 0; d > f; f++) b[c + f] ^= e[f]
        },
        l = (c.BlockCipherMode = d.extend({
            createEncryptor: function(a, b) {
                return this.Encryptor.create(a, b)
            },
            createDecryptor: function(a, b) {
                return this.Decryptor.create(a, b)
            },
            init: function(a, b) {
                this._cipher = a, this._iv = b
            }
        })).extend();
    l.Encryptor = l.extend({
        processBlock: function(a, b) {
            var c = this._cipher,
                d = c.blockSize;
            k.call(this, a, b, d), c.encryptBlock(a, b), this._prevBlock = a.slice(b, b + d)
        }
    }), l.Decryptor = l.extend({
        processBlock: function(a, b) {
            var c = this._cipher,
                d = c.blockSize,
                e = a.slice(b, b + d);
            c.decryptBlock(a, b), k.call(this, a, b, d), this._prevBlock = e
        }
    }), j = j.CBC = l, l = (b.pad = {}).Pkcs7 = {
        pad: function(a, b) {
            for (var c = 4 * b, c = c - a.sigBytes % c, d = c << 24 | c << 16 | c << 8 | c, f = [], g = 0; c > g; g += 4) f.push(d);
            c = e.create(f, c), a.concat(c)
        },
        unpad: function(a) {
            a.sigBytes -= 255 & a.words[a.sigBytes - 1 >>> 2]
        }
    }, c.BlockCipher = i.extend({
        cfg: i.cfg.extend({
            mode: j,
            padding: l
        }),
        reset: function() {
            i.reset.call(this);
            var a = this.cfg,
                b = a.iv,
                a = a.mode;
            if (this._xformMode == this._ENC_XFORM_MODE) var c = a.createEncryptor;
            else c = a.createDecryptor, this._minBufferSize = 1;
            this._mode = c.call(a, this, b && b.words)
        },
        _doProcessBlock: function(a, b) {
            this._mode.processBlock(a, b)
        },
        _doFinalize: function() {
            var a = this.cfg.padding;
            if (this._xformMode == this._ENC_XFORM_MODE) {
                a.pad(this._data, this.blockSize);
                var b = this._process(!0)
            } else b = this._process(!0), a.unpad(b);
            return b
        },
        blockSize: 4
    });
    var m = c.CipherParams = d.extend({
            init: function(a) {
                this.mixIn(a)
            },
            toString: function(a) {
                return (a || this.formatter).stringify(this)
            }
        }),
        j = (b.format = {}).OpenSSL = {
            stringify: function(a) {
                var b = a.ciphertext;
                return a = a.salt, (a ? e.create([1398893684, 1701076831]).concat(a).concat(b) : b).toString(g)
            },
            parse: function(a) {
                a = g.parse(a);
                var b = a.words;
                if (1398893684 == b[0] && 1701076831 == b[1]) {
                    var c = e.create(b.slice(2, 4));
                    b.splice(0, 4), a.sigBytes -= 16
                }
                return m.create({
                    ciphertext: a,
                    salt: c
                })
            }
        },
        n = c.SerializableCipher = d.extend({
            cfg: d.extend({
                format: j
            }),
            encrypt: function(a, b, c, d) {
                d = this.cfg.extend(d);
                var e = a.createEncryptor(c, d);
                return b = e.finalize(b), e = e.cfg, m.create({
                    ciphertext: b,
                    key: c,
                    iv: e.iv,
                    algorithm: a,
                    mode: e.mode,
                    padding: e.padding,
                    blockSize: a.blockSize,
                    formatter: d.format
                })
            },
            decrypt: function(a, b, c, d) {
                return d = this.cfg.extend(d), b = this._parse(b, d.format), a.createDecryptor(c, d).finalize(b.ciphertext)
            },
            _parse: function(a, b) {
                return "string" == typeof a ? b.parse(a, this) : a
            }
        }),
        b = (b.kdf = {}).OpenSSL = {
            execute: function(a, b, c, d) {
                return d || (d = e.random(8)), a = h.create({
                    keySize: b + c
                }).compute(a, d), c = e.create(a.words.slice(b), 4 * c), a.sigBytes = 4 * b, m.create({
                    key: a,
                    iv: c,
                    salt: d
                })
            }
        },
        o = c.PasswordBasedCipher = n.extend({
            cfg: n.cfg.extend({
                kdf: b
            }),
            encrypt: function(a, b, c, d) {
                return d = this.cfg.extend(d), c = d.kdf.execute(c, a.keySize, a.ivSize), d.iv = c.iv, a = n.encrypt.call(this, a, b, c.key, d), a.mixIn(c), a
            },
            decrypt: function(a, b, c, d) {
                return d = this.cfg.extend(d), b = this._parse(b, d.format), c = d.kdf.execute(c, a.keySize, a.ivSize, b.salt), d.iv = c.iv, n.decrypt.call(this, a, b, c.key, d)
            }
        })
}(),
    function() {
        function a() {
            for (var a = this._X, b = this._C, c = 0; 8 > c; c++) e[c] = b[c];
            for (b[0] = b[0] + 1295307597 + this._b | 0, b[1] = b[1] + 3545052371 + (b[0] >>> 0 < e[0] >>> 0 ? 1 : 0) | 0, b[2] = b[2] + 886263092 + (b[1] >>> 0 < e[1] >>> 0 ? 1 : 0) | 0, b[3] = b[3] + 1295307597 + (b[2] >>> 0 < e[2] >>> 0 ? 1 : 0) | 0, b[4] = b[4] + 3545052371 + (b[3] >>> 0 < e[3] >>> 0 ? 1 : 0) | 0, b[5] = b[5] + 886263092 + (b[4] >>> 0 < e[4] >>> 0 ? 1 : 0) | 0, b[6] = b[6] + 1295307597 + (b[5] >>> 0 < e[5] >>> 0 ? 1 : 0) | 0, b[7] = b[7] + 3545052371 + (b[6] >>> 0 < e[6] >>> 0 ? 1 : 0) | 0, this._b = b[7] >>> 0 < e[7] >>> 0 ? 1 : 0, c = 0; 8 > c; c++) {
                var d = a[c] + b[c],
                    g = 65535 & d,
                    h = d >>> 16;
                f[c] = ((g * g >>> 17) + g * h >>> 15) + h * h ^ ((4294901760 & d) * d | 0) + ((65535 & d) * d | 0)
            }
            a[0] = f[0] + (f[7] << 16 | f[7] >>> 16) + (f[6] << 16 | f[6] >>> 16) | 0, a[1] = f[1] + (f[0] << 8 | f[0] >>> 24) + f[7] | 0, a[2] = f[2] + (f[1] << 16 | f[1] >>> 16) + (f[0] << 16 | f[0] >>> 16) | 0, a[3] = f[3] + (f[2] << 8 | f[2] >>> 24) + f[1] | 0, a[4] = f[4] + (f[3] << 16 | f[3] >>> 16) + (f[2] << 16 | f[2] >>> 16) | 0, a[5] = f[5] + (f[4] << 8 | f[4] >>> 24) + f[3] | 0, a[6] = f[6] + (f[5] << 16 | f[5] >>> 16) + (f[4] << 16 | f[4] >>> 16) | 0, a[7] = f[7] + (f[6] << 8 | f[6] >>> 24) + f[5] | 0
        }
        var b = CryptoJS,
            c = b.lib.StreamCipher,
            d = [],
            e = [],
            f = [],
            g = b.algo.Rabbit = c.extend({
                _doReset: function() {
                    for (var b = this._key.words, c = this.cfg.iv, d = 0; 4 > d; d++) b[d] = 16711935 & (b[d] << 8 | b[d] >>> 24) | 4278255360 & (b[d] << 24 | b[d] >>> 8);
                    for (var e = this._X = [b[0], b[3] << 16 | b[2] >>> 16, b[1], b[0] << 16 | b[3] >>> 16, b[2], b[1] << 16 | b[0] >>> 16, b[3], b[2] << 16 | b[1] >>> 16], b = this._C = [b[2] << 16 | b[2] >>> 16, 4294901760 & b[0] | 65535 & b[1], b[3] << 16 | b[3] >>> 16, 4294901760 & b[1] | 65535 & b[2], b[0] << 16 | b[0] >>> 16, 4294901760 & b[2] | 65535 & b[3], b[1] << 16 | b[1] >>> 16, 4294901760 & b[3] | 65535 & b[0]], d = this._b = 0; 4 > d; d++) a.call(this);
                    for (d = 0; 8 > d; d++) b[d] ^= e[d + 4 & 7];
                    if (c) {
                        var d = c.words,
                            c = d[0],
                            d = d[1],
                            c = 16711935 & (c << 8 | c >>> 24) | 4278255360 & (c << 24 | c >>> 8),
                            d = 16711935 & (d << 8 | d >>> 24) | 4278255360 & (d << 24 | d >>> 8),
                            e = c >>> 16 | 4294901760 & d,
                            f = d << 16 | 65535 & c;
                        for (b[0] ^= c, b[1] ^= e, b[2] ^= d, b[3] ^= f, b[4] ^= c, b[5] ^= e, b[6] ^= d, b[7] ^= f, d = 0; 4 > d; d++) a.call(this)
                    }
                },
                _doProcessBlock: function(b, c) {
                    var e = this._X;
                    for (a.call(this), d[0] = e[0] ^ e[5] >>> 16 ^ e[3] << 16, d[1] = e[2] ^ e[7] >>> 16 ^ e[5] << 16, d[2] = e[4] ^ e[1] >>> 16 ^ e[7] << 16, d[3] = e[6] ^ e[3] >>> 16 ^ e[1] << 16, e = 0; 4 > e; e++) d[e] = 16711935 & (d[e] << 8 | d[e] >>> 24) | 4278255360 & (d[e] << 24 | d[e] >>> 8), b[c + e] ^= d[e]
                },
                blockSize: 4,
                ivSize: 2
            });
        b.Rabbit = c._createHelper(g)
    }(),
    function() {
        var a = CryptoJS,
            b = a.lib.WordArray,
            a = a.enc;
        a.Utf16 = a.Utf16BE = {
            stringify: function(a) {
                var b = a.words;
                a = a.sigBytes;
                for (var c = [], d = 0; a > d; d += 2) c.push(String.fromCharCode(b[d >>> 2] >>> 16 - 8 * (d % 4) & 65535));
                return c.join("")
            },
            parse: function(a) {
                for (var c = a.length, d = [], e = 0; c > e; e++) d[e >>> 1] |= a.charCodeAt(e) << 16 - 16 * (e % 2);
                return b.create(d, 2 * c)
            }
        }, a.Utf16LE = {
            stringify: function(a) {
                var b = a.words;
                a = a.sigBytes;
                for (var c = [], d = 0; a > d; d += 2) c.push(String.fromCharCode((b[d >>> 2] >>> 16 - 8 * (d % 4) & 65535) << 8 & 4278255360 | (b[d >>> 2] >>> 16 - 8 * (d % 4) & 65535) >>> 8 & 16711935));
                return c.join("")
            },
            parse: function(a) {
                for (var c = a.length, d = [], e = 0; c > e; e++) {
                    var f = d,
                        g = e >>> 1,
                        h = f[g],
                        i = a.charCodeAt(e) << 16 - 16 * (e % 2);
                    f[g] = h | i << 8 & 4278255360 | i >>> 8 & 16711935
                }
                return b.create(d, 2 * c)
            }
        }
    }();
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
}]), angular.module("mpk").factory("cloudService", ["$http", "$log", "$q", "$timeout", "cryptoService", function(a, b, c, d, e) {
    return {
        cloudAddress: "https://my-personal-kanban.appspot.com",
        settings: {
            notLoaded: !0,
            encryptionKey: "my-random-key"
        },
        loadSettings: function() {
            var a = localStorage.getItem("myPersonalKanban.cloudSettings");
            return void 0 == a ? (this.settings = {
                notSetup: !0,
                encryptionKey: "my-random-key"
            }, this.settings) : (this.settings = angular.fromJson(a), this.settings.notSetup = !1, void 0 == this.settings.encryptionKey && (this.settings.encryptionKey = "my-random-key"), this.settings.useLocalCloud && (this.cloudAddress = this.settings.localCloudUrl), this.settings)
        },
        saveSettings: function(a) {
            return this.settings = a, localStorage.setItem("myPersonalKanban.cloudSettings", angular.toJson(this.settings, !1)), this.loadSettings(), this.settings
        },
        downloadKanban: function() {
            this.settings.notLoaded && this.loadSettings();
            var b = {
                kanbanKey: this.settings.kanbanKey,
                action: "get"
            };
            return a.jsonp(this.cloudAddress + "/service/kanban?callback=JSON_CALLBACK", {
                params: b
            })
        },
        uploadKanban: function(b) {
            function c(a, b) {
                for (var c = [], d = 0, e = a.length; e > d; d += b) c.push(a.slice(d, b + d));
                return c
            }

            function d(b) {
                var c = {
                    kanbanKey: h.settings.kanbanKey,
                    action: "put",
                    fragments: b
                };
                return a.jsonp(h.cloudAddress + "/service/kanban?callback=JSON_CALLBACK", {
                    params: c
                })
            }

            function f(b, c) {
                var d = {
                    kanbanKey: h.settings.kanbanKey,
                    action: "put",
                    chunk: b,
                    chunkNumber: c
                };
                return a.jsonp(h.cloudAddress + "/service/kanban?callback=JSON_CALLBACK", {
                    params: d
                })
            }

            function g(b) {
                var c = e.md5Hash(b),
                    d = {
                        kanbanKey: h.settings.kanbanKey,
                        action: "put",
                        hash: c
                    };
                return a.jsonp(h.cloudAddress + "/service/kanban?callback=JSON_CALLBACK", {
                    params: d
                })
            }
            this.settings.notLoaded && this.loadSettings();
            var h = this,
                i = e.encrypt(b, this.settings.encryptionKey),
                j = c(i, 1e3),
                k = d(j.length);
            return angular.forEach(j, function(a, b) {
                k = k.then(function() {
                    return f(a, b + 1)
                })
            }), k.then(function() {
                return g(i)
            })
        },
        isConfigurationValid: function() {
            return this.settings.notLoaded && this.loadSettings(), void 0 != this.settings.kanbanKey && "" != this.settings.kanbanKey
        }
    }
}]), angular.module("mpk").factory("kanbanRepository", ["cloudService", "cryptoService", function(a, b) {
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
            return localStorage.setItem("myPersonalKanban", a), this.kanbansByName
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
            return this.theme = a, this.save(), this.theme
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
            return this.kanbansByName = f.kanbans, this.lastUsed = f.lastUsed, this.theme = f.theme, this.lastUpdated = d, this.save(), {
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
        addCardToColumn: function(a, b, c, d, e) {
            angular.forEach(a.columns, function(a) {
                a.name === b.name && a.cards.push(new KanbanCard(c, d, e))
            })
        },
        removeCardFromColumn: function(a, b, c) {
            angular.forEach(a.columns, function(a) {
                a.name === b.name && a.cards.splice(a.cards.indexOf(c), 1)
            })
        },
        archiveCard: function(a, b, c) {
            void 0 == a.archived && (a.archived = []), a.archived.push({
                card: c,
                archivedOn: new Date
            }), this.removeCardFromColumn(a, b, c)
        },
        unarchiveCard: function(a, b) {
            function c(a) {
                return a.columns[a.columns.length - 1]
            }
            this.removeFromArchive(a, b), c(a).cards.push(b.card)
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
        addColumnNextToColumn: function(a, b, c) {
            var d = this.columnIndex(a, b);
            return "left" == c ? a.columns.splice(d, 0, new KanbanColumn("New column " + (a.numberOfColumns + 1))) : a.columns.splice(d + 1, 0, new KanbanColumn("New column " + (a.numberOfColumns + 1))), a.numberOfColumns++, a
        }
    }
}), angular.module("mpk").factory("themesProvider", ["$window", function(a) {
    var b = a.themes;
    return {
        getThemes: function() {
            return b
        },
        setCurrentTheme: function(a) {
            var b = document.getElementById("themeStylesheet"),
                c = b.href.substr(0, b.href.lastIndexOf("/"));
            return b.href = c + "/" + a + ".css", b.href
        },
        defaultTheme: "default-bright"
    }
}]), angular.module("mpk").factory("fileService", function() {
    return {
        saveBlob: function(a, b) {
            return saveAs(a, b)
        }
    }
}), angular.module("mpk").controller("ApplicationController", ["$scope", "$window", "kanbanRepository", "themesProvider", "$routeParams", "$location", "cloudService", function(a, b, c, d, e, f, g) {
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
            c.remove(a.kanban.name);
            var b = j(c);
            c.setLastUsed(b.length > 0 ? b[0] : void 0), a.kanban = void 0, a.allKanbans = Object.keys(c.all()), a.allKanbans.length > 0 && a.switchToKanban(a.allKanbans[0]), a.switchToList = a.allKanbans.slice(0), a.switchToList.splice(0, 0, "Switch to ...")
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
        c.renameLastUsedTo(a.newName), c.save(), a.allKanbans = Object.keys(c.all()), a.editingName = !1, a.switchToKanban(a.newName)
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
    var k = new Kanban("Kanban name", 0),
        l = c.load();
    l && (void 0 != e.kanbanName && c.get(e.kanbanName) ? k = c.get(e.kanbanName) : void 0 != c.getLastUsed() && (k = c.getLastUsed(), f.path("/kanban/" + k.name))), a.kanban = k, a.allKanbans = Object.keys(c.all()), a.selectedToOpen = a.newName = k.name, a.switchToList = a.allKanbans.slice(0), a.switchToList.splice(0, 0, "Switch to ..."), a.switchTo = "Switch to ...", a.$watch("kanban", function() {
        c.save()
    }, !0), a.columnHeight = angular.element(b).height() - 110, a.columnWidth = h(a.kanban.columns.length), a.triggerOpen = function() {
        a.$broadcast("TriggerOpenKanban")
    }, void 0 != c.getTheme() && "" != c.getTheme() && d.setCurrentTheme(c.getTheme())
}]);
var NewKanbanController = ["$scope", "kanbanRepository", "kanbanManipulator", function(a, b, c) {
    a.model = {}, a.$on("OpenNewKanban", function(b, c) {
        a.model.kanbanNames = c, a.model.kanbanName = "", a.model.numberOfColumns = 3, a.model.useTemplate = "", a.showNewKanban = !0
    }), a.createNew = function() {
        if (!this.newKanbanForm.$valid) return !1;
        var d = new Kanban(a.model.kanbanName, a.model.numberOfColumns);
        if ("" != a.model.useTemplate) {
            var e = b.all()[a.model.useTemplate];
            d = c.createNewFromTemplate(e, a.model.kanbanName)
        } else
            for (var f = 1; f < parseInt(a.model.numberOfColumns) + 1; f++) c.addColumn(d, "Column " + f);
        return b.add(d), a.kanbanName = "", a.numberOfColumns = 3, b.setLastUsed(d.name), a.$emit("NewKanbanAdded"), a.showNewKanban = !1, !0
    }
}];
angular.module("mpk").controller("NewKanbanController", NewKanbanController);
var CardController = ["$scope", function(a) {
    a.card = {}, a.editTitle = !1, a.editingDetails = !1, a.editingTitle = !1, a.$on("OpenCardDetails", function(b, c) {
        a.card = c, a.editingDetails = !1, a.editingTitle = !1, a.showCardDetails = !0
    })
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
        var b = a.model.column;
        return b.name = a.model.columnName, void 0 == b.settings && (b.settings = {}), b.settings.color = a.model.color, "" != a.model.limit && (b.settings.limit = a.model.limit), a.showColumnSettings = !1, !0
    }, a["delete"] = function() {
        a.model.showWarning ? (a.$emit("DeleteColumn", a.model.column), a.showColumnSettings = !1) : (a.model.showWarning = !0, b(function() {
            a.model.deleteDisabled = !1
        }, 2e3))
    }, a.addColumn = function(b) {
        a.$emit("AddColumn", a.model.column, b)
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
        return this.newCardForm.$valid ? (b.addCardToColumn(a.kanban, a.column, c.title, c.details, c.cardColor), a.newCard = angular.copy(a.master), a.showNewCard = !1, !0) : !1
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
    }), a.$on("AddColumn", function(c, d, e) {
        b.addColumnNextToColumn(a.kanban, d, e), a.$emit("ColumnsChanged"), a.$broadcast("CloseColumnSettings")
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
var SetupCloudController = ["$scope", "cloudService", function(a, b) {
    a.model = {
        useLocalCloud: !1,
        localCloudUrl: ""
    }, a.model.showConfigurationError = !0, a.showCloudSetup = !1, a.$on("OpenCloudSetup", function() {
        var c = b.loadSettings();
        c.notSetup || (a.model.kanbanKey = c.kanbanKey, a.model.encryptionKey = c.encryptionKey, a.model.useLocalCloud = c.useLocalCloud, a.model.localCloudUrl = c.localCloudUrl), a.showCloudSetup = !0
    }), a.saveSettings = function() {
        if (void 0 != a.model.kanbanKey && 0 != a.model.kanbanKey.length) {
            var c = {
                kanbanKey: a.model.kanbanKey,
                encryptionKey: a.model.encryptionKey,
                useLocalCloud: a.model.useLocalCloud,
                localCloudUrl: a.model.localCloudUrl
            };
            b.saveSettings(c), a.showCloudSetup = !1
        }
    }
}];
angular.module("mpk").controller("SetupCloudController", SetupCloudController), angular.module("mpk").controller("ExportController", ["$scope", "kanbanRepository", "fileService", function(a, b, c) {
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
        angular.forEach(a.model.archived, function(c) {
            c.selected && (a.model.archived.splice(a.model.archived.indexOf(c), 1), b.unarchiveCard(a.model.kanban, c.original))
        })
    }, a.deleteSelected = function() {
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
}), angular.module("mpk").directive("validKey", ["$http", "cloudService", function(a, b) {
    return {
        require: "ngModel",
        link: function(c, d, e, f) {
            function g() {
                var c = d.val(),
                    e = {
                        kanbanKey: c,
                        action: "key"
                    };
                a.jsonp(b.cloudAddress + "/service/kanban?callback=JSON_CALLBACK", {
                    params: e
                }).success(function(a) {
                    f.$setValidity("validKey", a.success), f.$setValidity("validKeyUnableToVerify", !0)
                }).error(function() {
                    f.$setValidity("validKeyUnableToVerify", !1)
                })
            }
            c.$watch(e.ngModel, g)
        }
    }
}]);