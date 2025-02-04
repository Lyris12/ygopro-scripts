--暗黒の瘴気
---@param c Card
function c41930553.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41930553,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1)
	e2:SetTarget(c41930553.target)
	e2:SetOperation(c41930553.operation)
	c:RegisterEffect(e2)
end
function c41930553.cfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsDiscardable()
end
function c41930553.rfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c41930553.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c41930553.rfilter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c41930553.cfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingTarget(c41930553.rfilter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c41930553.rfilter,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c41930553.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local cg=Duel.SelectMatchingCard(tp,c41930553.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	if cg:GetCount()==0 then return end
	Duel.SendtoGrave(cg,REASON_EFFECT+REASON_DISCARD)
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
