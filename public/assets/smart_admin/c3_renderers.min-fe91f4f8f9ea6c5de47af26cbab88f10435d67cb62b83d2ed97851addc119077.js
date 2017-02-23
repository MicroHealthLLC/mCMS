(function(){var e;(e=function(e){return"object"==typeof exports&&"object"==typeof module?e(require("jquery"),require("c3")):"function"==typeof define&&define.amd?define(["jquery","c3"],e):e(jQuery,c3)})(function(e,t){var n;return n=function(n){return null==n&&(n={}),function(i,o){var r,s,a,l,c,u,d,h,f,p,m,g,v,y,b,T,E,C,D,I,O,w,R,_,x,S,k,K,N,A,L,P,F,M,B,H,$,j,q,W,z,U,V,Y,G,X,J,Z,Q,ee,te,ne;if(v={localeStrings:{vs:"vs",by:"by"},c3:{}},o=e.extend(!0,v,o),null==(a=o.c3).size&&(a.size={}),null==(l=o.c3.size).width&&(l.width=window.innerWidth/1.4),null==(c=o.c3.size).height&&(c.height=window.innerHeight/1.4-50),null==n.type&&(n.type="line"),U=i.getRowKeys(),0===U.length&&U.push([]),p=i.getColKeys(),0===p.length&&p.push([]),C=function(){var e,t,n;for(n=[],e=0,t=p.length;t>e;e++)T=p[e],n.push(T.join("-"));return n}(),j=0,y=i.aggregatorName,i.valAttrs.length&&(y+="("+i.valAttrs.join(", ")+")"),"scatter"===n.type)for(Y={x:{},y:{},t:{}},s=i.rowAttrs.concat(i.colAttrs),Z=null!=(P=s[0])?P:"",E=null!=(F=s[1])?F:"",b=s.slice(2).join("-"),J=Z,""!==E&&(J+=" "+o.localeStrings.vs+" "+E),""!==b&&(J+=" "+o.localeStrings.by+" "+b),D=0,R=U.length;R>D;D++)for(z=U[D],I=0,_=p.length;_>I;I++)f=p[I],r=i.getAggregator(z,f),null!=r.value()&&(ee=z.concat(f),G=ee.slice(2).join("-"),""===G&&(G="series"),null==(u=Y.x)[G]&&(u[G]=[]),null==(d=Y.y)[G]&&(d[G]=[]),null==(h=Y.t)[G]&&(h[G]=[]),Y.y[G].push(null!=(M=ee[0])?M:0),Y.x[G].push(null!=(B=ee[1])?B:0),Y.t[G].push(r.format(r.value())));else{for(N=0,O=0,x=C.length;x>O;O++)te=C[O],N+=te.length;for(N>50&&(j=45),m=[],w=0,S=U.length;S>w;w++){for(z=U[w],W=z.join("-"),q=[""===W?i.aggregatorName:W],K=0,k=p.length;k>K;K++)f=p[K],Q=parseFloat(i.getAggregator(z,f).value()),isFinite(Q)?1>Q?q.push(Q.toPrecision(3)):q.push(Q.toFixed(3)):q.push(null);m.push(q)}Z=i.aggregatorName+(i.valAttrs.length?"("+i.valAttrs.join(", ")+")":""),E=i.colAttrs.join("-"),J=y,""!==E&&(J+=" "+o.localeStrings.vs+" "+E),b=i.rowAttrs.join("-"),""!==b&&(J+=" "+o.localeStrings.by+" "+b)}if(X=e("<p>",{style:"text-align: center; font-weight: bold"}),X.text(J),L={axis:{y:{label:Z},x:{label:E,tick:{rotate:j,multiline:!1}}},data:{type:n.type},tooltip:{grouped:!1},color:{pattern:["#3366cc","#dc3912","#ff9900","#109618","#990099","#0099c6","#dd4477","#66aa00","#b82e2e","#316395","#994499","#22aa99","#aaaa11","#6633cc","#e67300","#8b0707","#651067","#329262","#5574a6","#3b3eac"]}},e.extend(!0,L,o.c3),"scatter"===n.type){ne={},A=0,g=[];for(V in Y.x)A+=1,ne[V]=V+"_x",g.push([V+"_x"].concat(Y.x[V])),g.push([V].concat(Y.y[V]));L.data.xs=ne,L.data.columns=g,L.axis.x.tick={fit:!1},1===A&&(L.legend={show:!1}),L.tooltip.format={title:function(){return y},name:function(){return""},value:function(e,t,n,i){return Y.t[n][i]}}}else L.axis.x.type="category",L.axis.x.categories=C,L.data.columns=m;return null!=n.stacked&&(L.data.groups=[function(){var e,t,n;for(n=[],t=0,e=U.length;e>t;t++)te=U[t],n.push(te.join("-"));return n}()]),H=e("<div>",{style:"display:none;"}).appendTo(e("body")),$=e("<div>").appendTo(H),L.bindto=$[0],t.generate(L),$.detach(),H.remove(),e("<div>").append(X,$)}},e.pivotUtilities.c3_renderers={"Line Chart":n(),"Bar Chart":n({type:"bar"}),"Stacked Bar Chart":n({type:"bar",stacked:!0}),"Area Chart":n({type:"area",stacked:!0}),"Scatter Chart":n({type:"scatter"})}})}).call(this);