// OpenPencil eval helper. Set pknResizeRequest in root pluginData, then execute this file.
// Explicitly resizes generated viewport chrome; node.resize alone does not apply constraints.
const request=JSON.parse(figma.root.getPluginData('pknResizeRequest')||'{"screen":"H","width":412,"height":915}');
const screen=figma.root.findAll(n=>n.type==='FRAME'&&n.getPluginData('screenKey')===request.screen)[0];
if(!screen)throw new Error('Unknown screenKey: '+request.screen);
const width=Number(request.width),height=Number(request.height);
if(!Number.isFinite(width)||!Number.isFinite(height)||width<320||height<500)throw new Error('Viewport must be at least 320 × 500');
function axis(position,size,before,after,constraint){const delta=after-before;if(constraint==='MAX')return [position+delta,size];if(constraint==='CENTER')return [position+delta/2,size];if(constraint==='STRETCH')return [position,Math.max(1,size+delta)];if(constraint==='SCALE'&&before)return [position*after/before,size*after/before];return [position,size];}
function fit(node,w,h){const before=[node.width,node.height];const children=(node.children||[]).map(child=>({child,x:child.x,y:child.y,w:child.width,h:child.height,constraints:child.constraints||{}}));node.resize(w,h);for(const row of children){const [x,cw]=axis(row.x,row.w,before[0],w,row.constraints.horizontal);const [y,ch]=axis(row.y,row.h,before[1],h,row.constraints.vertical);fit(row.child,cw,ch);row.child.x=x;row.child.y=y;}}
const header=screen.children.find(n=>n.name==='Status & header');
const scroll=screen.children.find(n=>n.name==='Scroll viewport • content only');
const dock=screen.children.find(n=>n.name==='Docked CTA & safe navigation');
if(!header||!scroll||!dock)throw new Error('Screen lacks generated viewport chrome');
fit(screen,width,height);fit(header,width,88);header.x=0;header.y=0;
for(const node of header.children){if(node.type==='TEXT'&&node.characters==='Simpan')node.x=width-98;else if(node.type==='TEXT'&&node.y<30)fit(node,width-48,node.height);}
fit(scroll,width,height-252);scroll.x=0;scroll.y=88;
const content=scroll.children.find(n=>n.name==='Scrollable editable content');
if(content)fit(content,width,content.height);
fit(dock,width,164);dock.x=0;dock.y=height-164;
const action=dock.children.find(n=>n.name==='Docked primary action');
const nav=dock.children.find(n=>n.name==='Four-tab icon navigation');
fit(action,width-48,52);action.x=24;action.y=8;
const label=action.findAll(n=>n.type==='TEXT'&&n.name==='Action label')[0];fit(label,width-80,label.height);
fit(nav,width,88);nav.x=0;nav.y=76;
const icons=['Beranda icon','Tersimpan icon','Audio icon','Profil icon'];
for(const node of nav.children){if(node.type==='TEXT'&&node.name.startsWith('Tab ')){const i=Number(node.name.slice(4));node.x=i*width/4+4;fit(node,width/4-8,node.height);}else if(node.type==='VECTOR'){const i=icons.indexOf(node.name);if(i>=0)node.x=i*width/4+width/8-12;}else if(node.name==='Safe area inset')fit(node,width,24);}
for(const node of dock.children)if(node.type==='TEXT')fit(node,width-48,node.height);
return {screen:request.screen,viewport:[screen.width,screen.height],header:[header.width,header.height],scroll:[scroll.width,scroll.height],dock:[dock.x,dock.y,dock.width,dock.height],action:[action.x,action.y,action.width,action.height],nav:[nav.x,nav.y,nav.width,nav.height],note:'Explicit viewport chrome resize; content/cards remain editable at their designed mobile or tablet composition. This does not imply native automatic constraint execution.'};
